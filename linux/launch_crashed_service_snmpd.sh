#!/bin/bash

service snmpd status | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]
then
        sudo service snmpd restart > /dev/null
fi

#Crontab
#*/1 * * * * /opt/launch_crashed_service_snmpd.sh > /dev/null 2>
