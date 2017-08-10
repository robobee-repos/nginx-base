#!/bin/bash
set -xe

function check_files_exists() {
  ls "$1" 1> /dev/null 2>&1
}

function copy_file() {
  file="$1"; shift
  dir="$1"; shift
  if [ -e "$file" ]; then
    mkdir -p "$dir"
    cp "$file" "$dir/$file"
  fi
}

function copy_nginx_confd() {
  dir="/nginx-confd-in"
  if [ ! -d "${dir}" ]; then
    return
  fi
  cd "${dir}"
  if ! check_files_exists "*.conf"; then
    return
  fi
  rsync -v "${dir}/*.conf" /etc/nginx/conf.d/
}

function copy_nginx_conf() {
  dir="/nginx-in"
  if [ ! -d ${dir} ]; then
    return
  fi
  cd "${dir}"
  file="nginx.conf"
  copy_file "${file}" "/etc/nginx"
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

echo "Running as `id`"

copy_nginx_confd
copy_nginx_conf
update_nginx_conf

cd $WEB_ROOT
exec "$@"
