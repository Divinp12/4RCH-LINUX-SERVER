#!/bin/bash

yay -S --noconfirm pi-hole-server;

sudo systemctl enable pihole-FTL;

sudo systemctl start pihole-FTL;

pihole -g;

pihole -g -r recreate;
