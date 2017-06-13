#!/bin/bash
set -xe

function copy_nginx_confd() {
  cd /nginx-confd-in
  set +e
  cp *.conf /etc/nginx/conf.d/
  set -e
}

function copy_nginx_conf() {
  cd /nginx-in
  file="nginx.conf"
  dest="/etc/nginx/$file"
  if [ -e "$file" ]; then
    cp "$file" "$dest"
    chmod 0644 "$dest"
  fi
}

function do_sed() {
  ## TEMP File
  TFILE=`mktemp --tmpdir tfile.XXXXX`
  trap "rm -f $TFILE" 0 1 2 3 15

  file="$1"; shift
  search="$1"; shift
  replace="$1"; shift
  sed -r -e "s/^(${search}).*/${replace}/g" $file > $TFILE
  cat $TFILE > $file
}

function update_nginx_conf() {
  ##
  file="/etc/nginx/conf.d/default.conf"
  search="\s+listen\s+"
  replace="\1${NGINX_HTTP_PORT};"
  do_sed "$file" "$search" "$replace"
}

if [ -d /nginx-confd-in ]; then
  copy_nginx_confd
fi
if [ -d /nginx-in ]; then
  copy_nginx_conf
fi

update_nginx_conf

cd $HTTP_ROOT
exec "$@"
