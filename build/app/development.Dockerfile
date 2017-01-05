FROM php:5.6-fpm

# dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends nano
RUN apt-get install -y --no-install-recommends supervisor
RUN apt-get install -y --no-install-recommends php5-mysql
RUN apt-get install -y --no-install-recommends php5-mcrypt
RUN apt-get install -y --no-install-recommends php5-ldap
RUN apt-get install -y --no-install-recommends unzip
RUN apt-get clean all

# php ioncube
WORKDIR /tmp
RUN curl -L http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube_loaders.tar.gz
RUN tar xvf ioncube_loaders.tar.gz
RUN cp ioncube/ioncube_loader_lin_5.6.so /usr/lib/php5/20131226
RUN rm -rf ioncube*

# executables
COPY ./bin/run.sh /run.sh

RUN chmod +x /run.sh

# config files
COPY ./config/supervisord.conf /etc/supervisor/conf.d
COPY ./config/php.ini /usr/local/etc/php

WORKDIR /var/www

EXPOSE 9000

VOLUME ["/var/www/app"]

CMD ["/run.sh"]
