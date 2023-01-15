#!/bin/bash

# Write the flag.txt file
echo $FLAGTXT | base64 > /home/user/flag.txt
unset FLAGTXT

STAGE=$(hostname | cut -d- -f1)

# Start gotty
/usr/local/bin/gotty --permit-write --reconnect --title-format $STAGE /bin/bash &

# start Flask web server
python /app/app.py &

wait