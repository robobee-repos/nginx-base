FROM  nginx:1.13.1
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

ARG APT_CACHE
ENV WEB_ROOT /var/www/html
ENV NGINX_HTTP_PORT 8080
ENV NGINX_HTTPS_PORT 8443

RUN set -x \
  # Optional add proxy entries for apt.
  && if [ -n "${APT_CACHE}" ]; then \
  echo Acquire::ftp::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::http::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::https::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  fi \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y certbot rsync \
  && rm -rf /var/lib/apt/lists/*

RUN set -x \
  && mkdir -p /nginx-in \
  && mkdir -p /nginx-confd-in \
  && mkdir -p /var/cache/nginx \
  # Set permissions for non-root user.
  && chown nginx.nginx /etc/nginx/nginx.conf \
  && chown nginx.nginx -R /etc/nginx/conf.d \
  && chown nginx.nginx -R /var/cache/nginx \
  && chmod o+rwX /var/run

# Install docker-entrypoint.sh

ADD rootfs/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN set -x \
  && chmod +x /usr/local/bin/docker-entrypoint.sh

# Finishing up.

WORKDIR $WEB_ROOT

EXPOSE 8080
EXPOSE 8443

VOLUME /nginx-in
VOLUME /nginx-confd-in
VOLUME /var/cache/nginx

USER nginx
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
