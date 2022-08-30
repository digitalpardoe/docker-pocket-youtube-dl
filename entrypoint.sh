#!/bin/bash

if [[ $PUID ]] && [[ $PGID ]]; then
  groupadd -g $PGID -o container
  useradd -u $PUID -g $PGID -m -s /bin/bash -o container
fi

echo '* * * * * su -c "/usr/local/bin/pocket-youtube-dl" $(id -nu container) >> /var/log/cron.log 2>&1 ' > /etc/cron.d/run
chmod 0644 /etc/cron.d/run
crontab /etc/cron.d/run

cron

tail -f /var/log/cron.log
