#!/bin/sh

set -e   # Stop if things blow up
set -x   # Warn us if we reference an unbound variable

curl -X POST https://api.digitalocean.com/v2/droplets \
-H 'Content-Type: application/json' \
-H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
-d '{"name":"example.com", "region":"nyc3", "size":"512mb",
     "image":"9128941", "ssh_keys":[],

     "user_data":"
#cloud-config

runcmd:
  - apt-get -y install git
  - git clone https://github.com/daveworth/sample_app_rails_4.git /opt/apps/sample_app_rails_4
  - docker build -t sample_app_rails_4 /opt/apps/sample_app_rails_4
  - docker run --name sample_app_rails_4  -p 80:3000 -p 443:3000 -d sample_app_rails_4
"}'
