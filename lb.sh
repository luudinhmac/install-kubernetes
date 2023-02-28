#!/bin/bash
apt install nginx -y
cd /etc/nginx
mkdir k8s-lb.d
cd k8s-lb.d
cat sudo tee /etc/nginx/k8s-lb.d/apiserver.con <<EOF
stream {
        upstream kubernetes {
     server 10.0.0.1:6443 max_fails=3 fail_timeout=30s;
     server 10.0.0.2:6443 max_fails=3 fail_timeout=30s;
     server 10.0.0.3:6443 max_fails=3 fail_timeout=30s;
  }
  server {
               listen 6443;
               #listen 443;
                proxy_pass kubernetes;
             }
  }
EOF
