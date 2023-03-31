#!/bin/bash

echo "Waiting for db";
while ! nc -z db 5432;
do
    sleep 1;
done;
echo "Connected to db";

service cron restart
crontab /etc/crontab

exec "$@"