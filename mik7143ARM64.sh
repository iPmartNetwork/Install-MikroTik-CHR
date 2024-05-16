#!/bin/bash -e

apt update
apt install -y pwgen coreutils unzip
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
#!/bin/bash

#ADDRESS=xxx.xxx.xxx.xxx/24
ADDRESS=`ip addr show enp0s3 | grep global | cut -d' ' -f 6 | head -n 1`
#GATEWAY=xxx.xxx.xxx.1
GATEWAY=`ip route list | grep default | cut -d' ' -f 3`

wget https://download.mikrotik.com/routeros/7.14.3/chr-7.14.3.img.zip -O chr.img.zip  && \
gunzip -c chr.img.zip > chr.img  && \
mount -o loop,offset=33571840 chr.img /mnt
echo "Username: admin"
echo "Password: admin"
echo "/ip address add address=$ADDRESS interface=[/interface ethernet find where name=ether1]" > /mnt/rw/autorun.scr
echo "/ip route add gateway=$GATEWAY" >> /mnt/rw/autorun.scr
echo "/ip service disable telnet" >> /mnt/rw/autorun.scr
echo "/user set 0 name=admin password=admin" >> /mnt/rw/autorun.scr
echo "/ip dns set server=8.8.8.8,1.1.1.1" >> /mnt/rw/autorun.scr
# remount all mounted filesystems to read-only mode
echo u > /proc/sysrq-trigger
dd if=chr.img bs=1024 of=/dev/sda
echo "sync disk"
# synchronize all mounted filesystems
echo s > /proc/sysrq-trigger
echo "Sleep 10 seconds"
#/usr/bin/sleep 10
read -t 10 -u 1
# perform an immediate OS reboot similar to the RESET button (without synchronising and unmounting file systems)
echo b > /proc/sysrq-trigger
echo "
____________________________________________________________________________________
        ____                             _     _                                     
    ,   /    )                           /|   /                                  /   
-------/____/---_--_----__---)__--_/_---/-| -/-----__--_/_-----------__---)__---/-__-
  /   /        / /  ) /   ) /   ) /    /  | /    /___) /   | /| /  /   ) /   ) /(    
_/___/________/_/__/_(___(_/_____(_ __/___|/____(___ _(_ __|/_|/__(___/_/_____/___\__
                                                                                     
"
echo "Ok, reboot"
