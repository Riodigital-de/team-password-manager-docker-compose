FROM php:5.6-fpm

# dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends nano supervisor php5-mysql php5-mcrypt php5-ldap unzip \
  && apt-get clean all

# php ioncube
WORKDIR /tmp
RUN curl -L http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube_loaders.tar.gz \
  && tar xvf ioncube_loaders.tar.gz \
  && cp ioncube/ioncube_loader_lin_5.6.so /usr/lib/php5/20131226 \
  && rm -rf ioncube*

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
