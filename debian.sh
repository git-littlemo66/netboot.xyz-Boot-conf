#!/bin/bash

clear

echo ''
echo ''
echo '=========================='
echo '=====脚本来自：littlemo.cc====='
echo '=========================='
echo ''
echo ''

sleep 2s

apt-get install wget -y

find /boot -name "netboot.xyz.lkrn" -exec rm -fr {} \;

find /boot -name "netboot.xyz-initrd" -exec rm -fr {} \;

cd /boot

wget https://boot.netboot.xyz/ipxe/netboot.xyz.lkrn

touch /boot/netboot.xyz-initrd

cat > /boot/netboot.xyz-initrd << EOF
#!ipxe
#/boot/netboot.xyz-initrd
imgfree
dhcp
set dns 8.8.8.8
ifconfig
chain --autofree https://boot.netboot.xyz
EOF

cat > /etc/grub.d/40_custom << EOF
#!/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the 'exec tail' line above.
menuentry 'netboot.xyz' {
set root='hd0,msdos1'
linux16 /boot/netboot.xyz.lkrn
initrd16 /boot/netboot.xyz-initrd
}
EOF

sed -i '/^GRUB_TIMEOUT/d' /etc/default/grub

echo "GRUB_TIMEOUT=60" >> /etc/default/grub

grub2-mkconfig -o /etc/grub2.cfg

echo ''
echo ''
echo ''
echo ''
echo '配置已完成，请连接VNC后输入重启命令：reboot'
echo ''
echo ''
