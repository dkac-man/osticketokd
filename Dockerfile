FROM docker.io/osticket/osticket:latest

RUN rm -f /var/www/html/index.html

# Apache na 8080 (non-root friendly)
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
 && sed -i 's/:80/:8080/' /etc/apache2/sites-enabled/000-default.conf
# prawa pod OpenShift/OKD
RUN chgrp -R 0 /var/www/html \
 && chmod -R g+rwX /var/www/html

EXPOSE 8080