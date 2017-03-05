from flask import Flask, request, render_template, jsonify
from flask_bootstrap import Bootstrap
import subprocess

def create_app():
    app = Flask(__name__)
    Bootstrap(app)
    return app

app = create_app()

def get_users_list():
    ul = subprocess.check_output(['./create_user.sh', '-L'])
    return ul.split('\n')[:-1]

def get_self():
    ms = subprocess.check_output(['./create_user.sh', '-S'])
    return ms.split('\n')[:-1]

@app.route("/get_users_list")
def get_users_list():
    users_list = get_users_list()
    myself = get_self()
    users_list.remove(myself[0])

    return jsonify(users_list)

@app.route("/")
def manage_users():
    users_list = get_users_list()
    myself = get_self()
    users_list.remove(myself[0])
    
    return render_template('manage_users.html', users_list=users_list)

@app.route('/delete_user')
def delete_user():
    delete_home_dir = request.args.get('del_dir')
    uname = request.args.get('uname')

    if delete_home_dir=='true':
        delete_options = ['./create_user.sh', "-D "+ uname.encode('utf8')+" -r"]
    else:
        delete_options = ['./create_user.sh', "-D "+ uname.encode('utf8')]

    print "delete options"
    print delete_options

    delete_user = subprocess.Popen(delete_options, stdout=subprocess.PIPE)
    delete_response = delete_user.communicate()
    
    print "delete response"
    print delete_response
    
    return jsonify(delete_response)

if __name__ == "__main__":
    app.run(debug=True)
