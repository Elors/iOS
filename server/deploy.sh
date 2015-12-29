#!/bin/sh

DES=/opt/jenkins/mala/server
ENV=/opt/jenkins/env
SET=/opt/keys-pros

mkdir -p $DES
rm -rf $DES/*
cp -Rf server/* $DES/
cp -Rf $SET/local_settings.py $DES/

cd $DES
. $ENV/bin/activate
pip install -r pip_install.txt
python manage.py migrate
if [ -n "`ps aux | grep gunicorn | grep server.wsgi| awk '{ print $2 }'`" ]
then
    echo 'Restarting gunicorn...'
    ps aux | grep gunicorn | grep server.wsgi| awk '{ print $2 }' | xargs kill -HUP
    echo 'Restarted.'
else
    echo 'Starting gunicorn...'
    gunicorn server.wsgi:application --bind 127.0.0.1:8001 &
    echo 'Started.'
fi
