#!/usr/bin/env bash

# copy template ngnix conf over actual conf
cp /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf

# replace env DOMAIN every time the container is started
sed -i "s/xxxDOMAINxxx/${DOMAIN}/g" /etc/nginx/nginx.conf

# run nginx and certbot renewal cron via supervisor
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
