#!/bin/bash
apt update -y && apt install -y screen wget tar git

cd /root
[ -d yui56 ] || git clone https://github.com/amirul5656/yui56.git
cd yui56

[ -f hellminer ] || {
  wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz
  tar -xvzf hellminer_linux64.tar.gz
  chmod +x hellminer
}

# Daftar stratum (tambahkan sesuai kebutuhan)
stratums=(
  "stratum+tcp://sg.vipor.net:5040"
  "stratum+tcp://cn.vipor.net:5040"
  "stratum+tcp://ap.vipor.net:5040"
  "stratum+tcp://au.vipor.net:5040"
  "stratum+tcp://tr.vipor.net:5040"
  "stratum+tcp://usw.vipor.net:5040"
  "stratum+tcp://ro.vipor.net:5040"
  "stratum+tcp://fi.vipor.net:5040"
  "stratum+tcp://us.vipor.net:5040"
  "stratum+tcp://ua.vipor.net:5040"
  "stratum+tcp://usse.vipor.net:5040"
  "stratum+tcp://ussw.vipor.net:5040"
  "stratum+tcp://de.vipor.net:5040"
  "stratum+tcp://fr.vipor.net:5040"
  "stratum+tcp://kz.vipor.net:5040"
  "stratum+tcp://ru.vipor.net:5040"
  "stratum+tcp://pl.vipor.net:5040"
  "stratum+tcp://ca.vipor.net:5040"
  "stratum+tcp://sa.vipor.net:5040"
)

# Pilih stratum secara acak
RANDOM_STRATUM=${stratums[$RANDOM % ${#stratums[@]}]}

screen -list | grep -q amirul3 || screen -dmS amirul3 bash -c "
  while true; do
    echo '🔀 Menggunakan stratum: $RANDOM_STRATUM'
    taskset -c 0-3 ./hellminer -c $RANDOM_STRATUM -u RQdUotwPueFvRY5xKfn6REsMUsBdhhmqdq.amirul -p x --threads 7
    sleep 2
    RANDOM_STRATUM=\${stratums[\$RANDOM % \${#stratums[@]}]}
  done
"
