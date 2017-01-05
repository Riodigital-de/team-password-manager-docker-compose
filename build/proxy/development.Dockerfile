FROM nginx:stable

# dependencies
RUN set -x
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y --no-install-recommends supervisor
RUN apt-get install -y --no-install-recommends cron
RUN apt-get install -y --no-install-recommends nano

# executables
COPY ./bin/run.sh /run.sh

RUN chmod +x /run.sh

# config files
COPY ./config/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 443

VOLUME ["/var/log/"]

CMD ["/run.sh"]
