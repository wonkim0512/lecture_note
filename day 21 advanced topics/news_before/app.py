# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

from flask import Flask, jsonify, render_template, request, url_for

app = Flask(__name__)

'''
    Basic example
     - plain text
     - json
     - html
'''
@app.route('/txt_test')
def hello_plain():
    return 'plain text'

@app.route('/json_test')
def hello_json():
    data = {'name' : 'Aaron', 'family' : 'Byun'}
    return jsonify(data)

@app.route('/html_test')
def hello_html():
    # html file은 templates 폴더에 위치해야 함
    return render_template('simple.html')


@app.route('/simple')
def simple():
    # html file은 templates 폴더에 위치해야 함
    gadgets = []
    gadgets.append({'name' : 'galaxy s7', 'manufacturer' : 'samsung', 'date' : 2017})
    gadgets.append({'name' : 'macbook', 'manufacturer' : 'apples', 'date' : 2016})
    gadgets.append({'name' : 'action cam', 'manufacturer' : 'sony', 'date' : 2017})

    return render_template('simple2.html',
                                        name = 'aaron',
                                        age=26,
                                        languages = ['python', 'java', 'c++', 'c#'],
                                        gadgets = gadgets)
@app.route('/subscription')
def subscription():
    # html file은 templates 폴더에 위치해야 함

    return render_template('subscription.html')


from pymongo import MongoClient, DESCENDING

@app.route('/simple_post', methods=['POST'])
def simple_post():
    name = request.form['name']
    age = request.form['age']

    print name, age

    mongo = MongoClient(host='ec2-35-167-74-63.us-west-2.compute.amazonaws.com', port=27017)
    test = mongo.data2.user

    test.insert_one({'name' : name, 'age' : age})

    mongo.close()

    return '이름 :  {} 나이 : {} 등록 완료'.format(name, age)

@app.route('/subscription_post', methods=['POST'])
def subscription_post():
    ID = request.form['ID']
    PWD = request.form['PWD']

    print ID, PWD

    mongo = MongoClient(host='ec2-35-167-74-63.us-west-2.compute.amazonaws.com', port=27017)
    test = mongo.data2.subscription

    test.insert_one({'ID' : ID, 'PWD' : PWD})

    mongo.close()

    return 'ID :  {} PWD : {} 가입 완료'.format(ID, PWD)


if __name__ == '__main__':
    # 모든 호스트에서 접속 가능
    # port : 8080, aws에서 8080을 열어줘야 접속 가능
    app.run(debug=True, host='0.0.0.0', port=8022)
