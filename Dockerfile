FROM docker.io/campbellsoftwaresolutions/osticket:latest

# OpenShift/OKD: losowy UID, często z GID=0, więc dajemy prawa grupie 0
RUN chgrp -R 0 /bin /data /var/www || true \
 && chmod -R g+rwX /data /var/www || true \
 && chmod g+x /bin/update /bin/entrypoint || true
