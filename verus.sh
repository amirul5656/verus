#!/bin/bash
apt update -y && apt install -y screen wget tar git

cd /root
[ -d verus ] || git clone https://github.com/amirul5656/verus.git
cd verus

[ -f hellminer ] || {
  wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz
  tar -xvzf hellminer_linux64.tar.gz
  chmod +x hellminer
}

# Mulai mining dengan screen jika belum aktif
screen -list | grep -q amirul3 || screen -dmS amirul3 bash << 'EOF'
cd /root/verus

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

while true; do
  stratum=${stratums[$RANDOM % ${#stratums[@]}]}
  echo "🔀 Menggunakan stratum: $stratum"
  ./hellminer -c "$stratum" -u RQdUotwPueFvRY5xKfn6REsMUsBdhhmqdq.amirul -p x --threads 7
  sleep 2
done
EOF
