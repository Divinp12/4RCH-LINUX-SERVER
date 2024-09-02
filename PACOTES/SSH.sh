#!/bin/bash

yay -S --noconfirm --quiet openssh && \
sudo systemctl enable sshd && \
sudo systemctl start sshd;
