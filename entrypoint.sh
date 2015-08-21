#!/bin/bash

# Build an nginx config with a server for each linked container

IFS=$'\n'

(
    for host in $(export | grep "_NAME="); do
        export_name=$(echo $host | sed -e 's/^declare -x //' | sed -e 's/_NAME.*$//')
        host_name=$(eval basename \$${export_name}_NAME)
        host=$(eval echo \$${export_name}_PORT | sed -e 's/^tcp/http/')

cat <<EOF
server {
  listen 80;
  server_name ${host_name}.localhost;

  location / {
    proxy_pass ${host};
  }
}

EOF

    done
) > /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
