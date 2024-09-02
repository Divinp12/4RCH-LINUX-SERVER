#!/bin/bash

yay -S --noconfirm --quiet pi-hole-server && \
sudo systemctl enable pihole-FTL && \
sudo systemctl start pihole-FTL && \
pihole -g && \
echo "https://blocklistproject.github.io/Lists/abuse.txt
https://blocklistproject.github.io/Lists/alt-version/abuse-nl.txt
https://blocklistproject.github.io/Lists/ads.txt
https://blocklistproject.github.io/Lists/alt-version/ads-nl.txt
https://blocklistproject.github.io/Lists/crypto.txt
https://blocklistproject.github.io/Lists/alt-version/crypto-nl.txt
https://blocklistproject.github.io/Lists/drugs.txt
https://blocklistproject.github.io/Lists/alt-version/drugs-nl.txt
https://blocklistproject.github.io/Lists/everything.txt
https://blocklistproject.github.io/Lists/alt-version/everything-nl.txt
https://blocklistproject.github.io/Lists/facebook.txt
https://blocklistproject.github.io/Lists/alt-version/facebook-nl.txt
https://blocklistproject.github.io/Lists/fraud.txt
https://blocklistproject.github.io/Lists/alt-version/fraud-nl.txt
https://blocklistproject.github.io/Lists/gambling.txt
https://blocklistproject.github.io/Lists/alt-version/gambling-nl.txt
https://blocklistproject.github.io/Lists/malware.txt
https://blocklistproject.github.io/Lists/alt-version/malware-nl.txt
https://blocklistproject.github.io/Lists/phishing.txt
https://blocklistproject.github.io/Lists/alt-version/phishing-nl.txt
https://blocklistproject.github.io/Lists/piracy.txt
https://blocklistproject.github.io/Lists/alt-version/piracy-nl.txt
https://blocklistproject.github.io/Lists/porn.txt
https://blocklistproject.github.io/Lists/alt-version/porn-nl.txt
https://blocklistproject.github.io/Lists/ransomware.txt
https://blocklistproject.github.io/Lists/alt-version/ransomware-nl.txt
https://blocklistproject.github.io/Lists/redirect.txt
https://blocklistproject.github.io/Lists/alt-version/redirect-nl.txt
https://blocklistproject.github.io/Lists/scam.txt
https://blocklistproject.github.io/Lists/alt-version/scam-nl.txt
https://blocklistproject.github.io/Lists/tiktok.txt
https://blocklistproject.github.io/Lists/alt-version/tiktok-nl.txt
https://blocklistproject.github.io/Lists/torrent.txt
https://blocklistproject.github.io/Lists/alt-version/torrent-nl.txt
https://blocklistproject.github.io/Lists/tracking.txt
https://blocklistproject.github.io/Lists/alt-version/tracking-nl.txt" >> /etc/pihole/adlists.list && \
pihole -g -r recreate;
