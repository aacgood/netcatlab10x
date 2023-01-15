import os

currentStage = os.environ.get("CURRENT_STAGE")
unlock = os.environ.get("UNLOCK")

try:
    nextFlag = os.environ.get("GOTTY_CREDENTIAL").split(':')[1]
except:
    nextFlag = 'welcome'

hint = f'''

HINT: You must make a POST request with the correct flag in json format
To get you started, the flag to submit stage0 is 'welcome'

eg: curl -XPOST http://stage0:5000 -H 'Content-Type':'application/json' -d'{{"flag":"welcome"}}'

'''

correct = f'''

CONGRATULATIONS!

You have successfully submitted the correct flag to unlock {currentStage}.  Use this to access the webterminal in a new tab.

username: flag
password: {nextFlag}

'''