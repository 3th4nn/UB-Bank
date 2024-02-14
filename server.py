import mysql.connector
from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

# Connect to the remote MySQL database
db_config = {
    'host': 'your_mysql_host',
    'user': 'your_mysql_user',
    'password': 'your_mysql_password',
    'database': 'your_mysql_database'
}

conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/branches')
def branches():
    return render_template('branches.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if verify_login(username, password):
            return redirect(url_for('user_profile', username=username))
        else:
            flash('Invalid username or password', 'error')
    return render_template('login.html')

@app.route('/user/<username>')
def user_profile(username):
    cursor.execute("SELECT checking_balance, savings_balance FROM users WHERE username = %s", (username,))
    row = cursor.fetchone()

    if row:
        checking_balance = row[0]
        savings_balance = row[1]
        return render_template('user_profile.html', username=username, checking_balance=checking_balance, savings_balance=savings_balance)
    else:
        flash('User not found', 'error')
        return redirect(url_for('login'))

def verify_login(username, password):
    cursor.execute("SELECT password FROM users WHERE username = %s", (username,))
    row = cursor.fetchone()
    if row:
        stored_password = row[0]
        if password == stored_password:
            return True
    return False

if __name__ == '__main__':
    app.run(debug=True)
