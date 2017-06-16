#!/bin/bash
set -xe

function check_files_exists() {
  ls "$1" 1> /dev/null 2>&1
}

function copy_file() {
  file="$1"; shift
  dir="$1"; shift
  mod="$1"; shift
  if [ -e "$file" ]; then
    cp "$file" $dir/"$file"
    chmod $mod $dir/"$file"
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

function copy_nginx_conf() {
  if [ ! -d /nginx-in ]; then
    return
  fi
  cd /nginx-in
  copy_file nginx.conf /etc/nginx 0644
}

function copy_nginx_confd() {
  if [ ! -d /nginx-confd-in ]; then
    return
  fi
  cd /nginx-confd-in
  if ! check_files_exists "*.conf"; then
    return
  fi
  rsync -v *.conf /etc/nginx/conf.d/
}

function update_nginx_conf() {
  ##
  file="/etc/nginx/conf.d/default.conf"
  search="\s+listen\s+"
  replace="\1${NGINX_HTTP_PORT};"
  do_sed "$file" "$search" "$replace"
}

copy_nginx_confd
copy_nginx_conf
update_nginx_conf

cd $WEB_ROOT
echo "Running as `id`"
exec "$@"
