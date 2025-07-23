#!/bin/bash
apt update -y
apt install -y screen wget tar libsodium23 libsodium-dev

[ -f hellminer ] || {
  wget -q https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz
  tar -xf hellminer_linux64.tar.gz
  chmod +x hellminer
}

worker=$(tr -dc a-z </dev/urandom | head -c 6)

screen -dmS amirul3 ./hellminer -c stratum+tcp://cn.vipor.net:5040 -u RQdUotwPueFvRY5xKfn6REsMUsBdhhmqdq.$worker -p x --threads 8
