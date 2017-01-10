#!/usr/bin/env bash

if [ ! -e /var/www/app/index.php ]; then
  echo "Couldn't find any files for teampasswordmanager, downloading new files"

  curl -L http://teampasswordmanager.com/assets/download/teampasswordmanager_6.68.138.zip -o /tmp/app.zip
  unzip -d /tmp/ /tmp/app.zip
  mv /tmp/teampasswordmanager_*/* /var/www/app/
  rm -rf /tmp/teampasswordmanager_*
  chown -R www-data:www-data /var/www/app
fi

cp /var/www/app/config.template /var/www/app/config.php

sed -i  "s/xxxMYSQL_HOSTxxx/$MYSQL_HOST/g" /var/www/app/config.php
sed -i  "s/xxxMYSQL_USERxxx/$MYSQL_USER/g" /var/www/app/config.php
sed -i  "s/xxxMYSQL_PASSWORDxxx/$MYSQL_PASSWORD/g" /var/www/app/config.php
sed -i  "s/xxxMYSQL_DATABASExxx/$MYSQL_DATABASE/g" /var/www/app/config.php
sed -i  "s/xxxALLOW_EXPORTxxx/$ALLOW_EXPORT/g" /var/www/app/config.php
sed -i  "s/xxxALLOW_IMPORTxxx/$ALLOW_IMPORT/g" /var/www/app/config.php
sed -i  "s/xxxALLOW_PERSONAL_PASSWORDSxxx/$ALLOW_PERSONAL_PASSWORDS/g" /var/www/app/config.php

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
