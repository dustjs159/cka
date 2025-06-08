#!/bin/zsh

PUBLIC_IP="$(curl -s ipinfo.io/ip)"

echo "{\"ip\": \"${PUBLIC_IP}\"}" # 이스케이프 넣고 JSON으로 전달