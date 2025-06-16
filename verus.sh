#!/bin/bash
apt update -y && apt install -y screen wget tar git

cd /root
[ -d yui56 ] || git clone https://github.com/amirul5656/verus.git
cd verus

[ -f hellminer ] || {
  wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz
  tar -xvzf hellminer_linux64.tar.gz
  chmod +x hellminer
}

screen -list | grep -q amirul3 || screen -dmS amirul3 bash -c '
  while true; do
    ./hellminer -c pool.verus.io:9999 -u RQdUotwPueFvRY5xKfn6REsMUsBdhhmqdq.amirul -p x --threads 7
    sleep 2
  done'
