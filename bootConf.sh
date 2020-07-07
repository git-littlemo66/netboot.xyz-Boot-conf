#!/bin/bash

clear

echo ''
echo ''
echo '=========================='
echo '=====脚本来自：sm.link====='
echo '=========================='
echo ''
echo ''

sleep 2s

yum -y install curl

curl https://boot.netboot.xyz/ipxe/netboot.xyz.lkrn -o /boot/generic-ipxe.lkrn

echo '#!ipxe' > /boot/netboot.xyz-initrd
echo '#/boot/netboot.xyz-initrd' >> /boot/netboot.xyz-initrd
echo 'imgfree' >> /boot/netboot.xyz-initrd
echo 'dhcp' >> /boot/netboot.xyz-initrd
echo 'set dns 8.8.8.8' >> /boot/netboot.xyz-initrd
echo 'ifopen net0' >> /boot/netboot.xyz-initrd
echo 'chain --autofree https://boot.netboot.xyz' >> /boot/netboot.xyz-initrd

echo 'exec tail -n +3 $0' > /etc/grub.d/40_custom
echo '# This file provides an easy way to add custom menu entries.  Simply type the' >> /etc/grub.d/40_custom
echo '# menu entries you want to add after this comment.  Be careful not to change' >> /etc/grub.d/40_custom
echo "# the 'exec tail' line above." >> /etc/grub.d/40_custom
echo "menuentry 'netboot.xyz' {" >> /etc/grub.d/40_custom
echo "set root='hd0,msdos1'" >> /etc/grub.d/40_custom
echo 'linux16 /boot/generic-ipxe.lkrn' >> /etc/grub.d/40_custom
echo 'initrd16 /boot/netboot.xyz-initrd' >> /etc/grub.d/40_custom
echo '}' >> /etc/grub.d/40_custom

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
