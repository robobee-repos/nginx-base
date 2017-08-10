FROM  nginx:1.13.1
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

RUN set -x \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y certbot \
  && rm -rf /var/lib/apt/lists/*

RUN set -x \
  && chown nginx.nginx /etc/nginx/nginx.conf \
  && chown nginx.nginx -R /etc/nginx/conf.d \
  && mkdir -p /var/nginx/cache \
  && chown nginx.nginx -R /var/cache/nginx \
  && chmod o+rwX /var/run

# Install docker-entrypoint.sh

ADD rootfs/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN set -x \
  && chmod +x /usr/local/bin/docker-entrypoint.sh

# Finishing up.

ENV HTTP_ROOT /var/www/html
ENV NGINX_HTTP_PORT 8080

WORKDIR $HTTP_ROOT

EXPOSE 8080
EXPOSE 8443

RUN set -x \
  && chown nginx.root -R /etc/nginx \
  && chmod u=rwX,g=rwX,o=rX -R /etc/nginx \
  && chown nginx.root -R /var/cache/nginx \
  && chmod u=rwX,g=rwX,o=rX -R /var/cache/nginx \
  && chown nginx.root -R /var/run \
  && chmod u=rwX,g=rwX,o=rX -R /var/run

USER nginx
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
