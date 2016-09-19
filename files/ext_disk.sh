# !/bin/bash

sudo fdisk /dev/xvda <<EEOF
d
n
p
1
1

w
EEOF
exit 0
