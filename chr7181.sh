#!/bin/bash -e

echo
echo "=== iPmart.Shop ==="
echo "
____________________________________________________________________________________
        ____                             _     _                                     
    ,   /    )                           /|   /                                  /   
-------/____/---_--_----__---)__--_/_---/-| -/-----__--_/_-----------__---)__---/-__-
  /   /        / /  ) /   ) /   ) /    /  | /    /___) /   | /| /  /   ) /   ) /(    
_/___/________/_/__/_(___(_/_____(_ __/___|/____(___ _(_ __|/_|/__(___/_/_____/___\__
                                                                                     
"
echo "***** https://github.com/ipmartnetwork *****"

echo "=== MikroTik 7 Installer ==="
echo
sleep 3
wget https://download.mikrotik.com/routeros/7.18.1/chr-7.18.1.img.zip -O chr.img.zip  && \
gunzip -c chr.img.zip > chr.img  && \
STORAGE=`lsblk | grep disk | cut -d ' ' -f 1 | head -n 1` && \
echo STORAGE is $STORAGE && \
ETH=`ip route show default | sed -n 's/.* dev \([^\ ]*\) .*/\1/p'` && \
echo ETH is $ETH && \
ADDRESS=`ip addr show $ETH | grep global | cut -d' ' -f 6 | head -n 1` && \
echo ADDRESS is $ADDRESS && \
GATEWAY=`ip route list | grep default | cut -d' ' -f 3` && \
echo GATEWAY is $GATEWAY && \
sleep 5 && \
dd if=chr.img of=/dev/$STORAGE bs=4M oflag=sync && \
echo "Ok, reboot" && \
echo 1 > /proc/sys/kernel/sysrq && \
echo b > /proc/sysrq-trigger && \
