#!/bin/bash
apt update -y && apt install -y screen wget tar git curl

cd /root
mkdir -p verus && cd verus

[ -f hellminer ] || {
  wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz
  tar -xvzf hellminer_linux64.tar.gz
  chmod +x hellminer
}

# Deteksi negara VPS
country=$(curl -s ipinfo.io/country)

# Tentukan stratum berdasarkan region
case "$country" in
  US|CA)
    stratum="stratum+tcp://us.vipor.net:5040"
    ;;
  SG|ID|MY|VN|TH|PH)
    stratum="stratum+tcp://sg.vipor.net:5040"
    ;;
  CN|HK)
    stratum="stratum+tcp://cn.vipor.net:5040"
    ;;
  AU|NZ)
    stratum="stratum+tcp://au.vipor.net:5040"
    ;;
  RU|UA|KZ|PL)
    stratum="stratum+tcp://ru.vipor.net:5040"
    ;;
  DE|FR|FI|RO|TR)
    stratum="stratum+tcp://de.vipor.net:5040"
    ;;
  *)
    stratum="stratum+tcp://usse.vipor.net:5040"
    ;;
esac

# Jalankan jika screen belum aktif
screen -list | grep -q amirul3 || screen -dmS amirul3 bash -c "
  cd /root/verus
  echo '🌐 Negara VPS: $country'
  echo '🔗 Stratum terdekat: $stratum'
  while true; do
    ./hellminer -c $stratum -u RQdUotwPueFvRY5xKfn6REsMUsBdhhmqdq.amirul -p x --threads 7
    sleep 2
  done
"
