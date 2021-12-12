# netboot.xyz-Boot-conf

### 一键脚本配置GRUB2+iPXE引导netboot.xyz进行网络重装

> 脚本参考自：https://lala.im/4524.html 感谢lala大佬

如果你还不知道netboot.xyz是什么，请先移步到 https://github.com/netbootxyz/netboot.xyz 查看后在使用本脚本。

#### 服务器需要满足以下条件：  
1.KVM虚拟化的VPS或者独立服务器  
2.网络支持DHCP(不是必须的)  
3.可以使用VNC控制你的机器  

----

#### 食用方法：
```
# centos
curl -O https://raw.githubusercontent.com/moqu66/netboot.xyz-Boot-conf/master/centos.sh && chmod +x centos.sh && ./centos.sh

# debian
curl -O https://raw.githubusercontent.com/moqu66/netboot.xyz-Boot-conf/master/debian.sh && chmod +x debian.sh && ./debian.sh
```

运行完毕后，请连接VNC，然后输入命令 `reboot` 重启机器，然后你就可以在引导页面看到 `netboot.xyz` 了
