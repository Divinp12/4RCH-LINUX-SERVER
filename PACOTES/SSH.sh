#!/bin/bash

yay -S --noconfirm openssh;

sudo systemctl enable sshd;

sudo systemctl start sshd;
