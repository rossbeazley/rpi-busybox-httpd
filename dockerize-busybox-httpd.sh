#!/bin/bash
set -e

dockerize -t hypriot/rpi-busybox-httpd \
   -a www /var/www \
   --entry '/bin/busybox' \
   --cmd 'httpd -f -p 80 -h /www' \
   /bin/busybox
