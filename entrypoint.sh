#!/bin/sh
set -e

# Tworzymy ost-config.php tylko jeśli nie istnieje (jak initContainer)
if [ ! -f /var/www/html/include/ost-config.php ]; then
  cp /var/www/html/include/ost-sampleconfig.php /var/www/html/include/ost-config.php
fi

# Daj zapis instalatorowi (lokalnie OKD-like)
chmod 0666 /var/www/html/include/ost-config.php || true

exec apache2-foreground