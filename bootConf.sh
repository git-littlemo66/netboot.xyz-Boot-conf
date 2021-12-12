#!/bin/bash

clear

echo ''
echo ''
echo '=========================='
echo '=====脚本来自：www.littlemo.cc====='
echo '=========================='
echo ''
echo ''

if [[ -f /etc/redhat-release ]]; then
  release="centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
  release="debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
  release="ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
  release="centos"
elif cat /proc/version | grep -q -E -i "debian"; then
  release="debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
  release="ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
  release="centos"
  fi

[[ ${release} != "debian" ]] && [[ ${release} != "ubuntu" ]] && [[ ${release} != "centos" ]] && echo -e "${Error} 本脚本不支持当前系统 ${release} !" && exit 1

if [[ "${release}" == "centos" ]]; then
  yum -y update && yum -y install wget
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
  apt-get -y update && apt-get -y install wget
fi

find /boot -name "netboot.xyz.lkrn" -exec rm -fr {} \;

find /boot -name "netboot.xyz-initrd" -exec rm -fr {} \;

wget -P /boot https://boot.netboot.xyz/ipxe/netboot.xyz.lkrn

touch /boot/netboot.xyz-initrd

cat > /boot/netboot.xyz-initrd << EOF
#!ipxe
#/boot/netboot.xyz-initrd
imgfree
:retry
ifconf --configurator dhcp || goto retry
set dns 8.8.8.8
ifopen
chain --autofree https://boot.netboot.xyz
EOF

cat > /etc/grub.d/40_custom << EOF
#!/bin/sh
exec tail -n +3 \$0
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

if [[ "${release}" == "centos" ]]; then
  grub2-mkconfig -o /etc/grub2.cfg
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
  update-grub
fi

echo ''
echo ''
echo ''
echo "配置完成，连接VNC后重启机器即可在启动菜单选择netboot.xy"
echo ''
echo ''
