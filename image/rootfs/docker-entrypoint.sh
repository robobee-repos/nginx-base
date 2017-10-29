#!/bin/bash
set -e

function update_nginx_conf() {
  ##
  file="/etc/nginx/conf.d/default.conf"
  search="\s+listen\s+"
  replace="\1${NGINX_HTTP_PORT};"
  do_sed_group "$file" "$search" "$replace"
  ##
  file="/etc/nginx/nginx.conf"
  search="pid\s+"
  replace="\1/run/nginx/nginx.pid;"
  do_sed_group "$file" "$search" "$replace"
}

source /docker-entrypoint-utils.sh
set_debug
echo "Running as `id`"
copy_files "/nginx-confd-in" "/etc/nginx/conf.d" "*.conf"
copy_files "/nginx-in" "/etc/nginx" "nginx.conf"
update_nginx_conf

cd $WEB_ROOT
exec "$@"
