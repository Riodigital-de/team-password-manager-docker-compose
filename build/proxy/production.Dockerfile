FROM nginx:stable

# dependencies
RUN set -x \
&& echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends supervisor cron nano

# executables
COPY ./bin/run.sh /run.sh

RUN chmod +x /run.sh

# config files
COPY ./config/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 443

VOLUME ["/var/log/"]

CMD ["/run.sh"]
