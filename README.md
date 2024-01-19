# Install-MikroTik-CHR-on-VPS
Easy way for install Mikrotik’s Cloud Hosted Router on any Cloud VM

## Prerequisites

```bash
  1:
  دسترسی به vnc سرور مجازی یا ssh
  2:
  این اطلاعات شبکه مورد نیاز است:
   آدرس IP - Net Mask - IP Gateway
  3:
در برخی موارد باید درایور Virtio را غیرفعال کنید!


## Find information manually
Find storage name
```bash
lsblk | grep disk | cut -d ' ' -f 1 | head -n 1
```
Find ethernet name
```bash
ip route show default | sed -n 's/.* dev \([^\ ]*\) .*/\1/p'
```
find ip address name
```bash
ip addr show $ETH | grep global | cut -d' ' -f 6 | head -n 1
```
find gateway name
```bash
ip route list | grep default | cut -d' ' -f 3
```
## Installation

For MikroTik 6.48.6

```bash
  bash -c "$(curl -L https://raw.githubusercontent.com/ipmartnetwork/Install-MikroTik-CHR/main/mik-711.sh)"
```

For MikroTik 7.10.2

```bash
  bash -c "$(curl -L https://raw.githubusercontent.com/ipmartnetwork/Install-MikroTik-CHR/main/mik7132.sh)"
```

After install be sure to turn off the server and turn on again
## Post installation settings

In some cases it is possible that the network settings inside the MikroTik may not be done correctly that you must manually and through the VNC console.
