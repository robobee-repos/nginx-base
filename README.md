# Nginx-Base

## Description

This is a base image for Nginx. It modifies the parent image insofar as the
Nginx serves per default on the ports `8080` and `8433` and is run as a 
non-priveleged user.

Furthermore,
it can take input configuration files to override the image configuration
files, allowing for Kubernetes config maps.

## Environment Parameters

| Variable | Default | Description |
| ------------- | ------------- | ----- |
| NGINX_HTTP_PORT | 8080 | Nginx HTTP port number. Overrides the listen directive in `/etc/nginx/conf.d/default.conf` because the container can not start on port 80. |
| NGINX_HTTPS_PORT | 8443 | Nginx HTTPS port number. |

## Input Configration

| Source | Destination |
| ------------- | ------------- |
| /nginx-in/nginx.conf | /etc/nginx/nginx.conf |
| /nginx-confd-in/*.conf | /etc/nginx/conf.d/ |

## License

Nginx is licensed 
under the [2-clause BSD-like](https://nginx.org/LICENSE) license.

Nginx Docker image is licensed 
under the [MIT](https://opensource.org/licenses/MIT) license.

Copyright 2017 Erwin Müller

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
