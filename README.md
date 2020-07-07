# netboot.xyz-Boot-conf

### 一键脚本配置GRUB2+iPXE引导netboot.xyz进行网络重装

> 脚本参考自：https://lala.im/4524.html 感谢lala大佬

如果你还不知道netboot.xyz是什么，请先移步到 https://github.com/netbootxyz/netboot.xyz 查看后在使用本脚本。

#### 服务器需要满足以下条件：  
1.KVM虚拟化的VPS或者独立服务器  
2.网络支持DHCP  
3.可以使用VNC控制你的机器  

----

#### 注意和建议
本脚本仅在`Linux CentOS7`下测试通过，其他版本系统未知！！！
解决方法：
如果你当前的服务器系统不是`CentOS7`，建议你先用你当前的服务器厂商面板重装系统为`CentOS7`，然后再运行本脚本。

----

#### 食用方法：
```
curl -O https://raw.githubusercontent.com/moqu66/netboot.xyz-Boot-conf/master/bootConf.sh && chmod +x bootConf.sh && bash bootConf.sh
```

运行完毕后，请连接VNC，然后输入命令 `reboot` 重启机器，然后你就可以在引导页面看到 `netboot.xyz` 了
