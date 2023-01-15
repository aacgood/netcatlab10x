from flask import Flask, request
from messages import hint, correct, currentStage, unlock, nextFlag
import socket, os, subprocess, json

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    
    hostname = socket.gethostname().split('-')[0]

    if request.method == 'GET':
        if hostname == 'stage9':
            fhand = open('flag.txt')
            return fhand
        else:
            return hint

    if request.method == 'POST':
        
        # Posted Data
        data = (request.get_json())
        
        if data['flag'] == unlock.strip():
            # Correct POST request, give next stage password
            return correct
    
        else:
            return hint

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000)