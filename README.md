# Nginx-Base

## Description

This is a base image for Nginx. It modifies the parent image insofar as the
Nginx serves per default on the ports 8080 and 8433 and is run as a 
non-priveleged user. It also adds Letsencrypt.

Furthermore,
it can take input configuration files to override the image configuration
files, allowing for Kubernetes config maps.

## Environment Parameters

| Variable | Default | Description |
| ------------- | ------------- | ----- |
| NGINX_HTTP_PORT | 8080 | Nginx HTTP port number. Overrides the Listen directive in /etc/nginx/conf.d/default.conf because the container can not start on port 80. |


## Input Configration

| Source | Destination |
| ------------- | ------------- |
| /nginx-in/nginx.conf | /etc/nginx/nginx.conf |
| /nginx-confd-in/*.conf | /etc/nginx/conf.d/ |

