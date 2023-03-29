# frpc_docker
## 项目简介
基于 [fatedier/frp](https://github.com/fatedier/frp) 原版 frp 内网穿透客户端 frpc 的一键安装卸载脚本和 docker 镜像.支持群晖NAS,Linux 服务器和 docker 等多种环境安装部署.

- GitHub [aircross/frpc_docker](https://github.com/aircross/frpc)
- Docker [aircross/frpc_docker](https://hub.docker.com/r/aircross/frpc_docker)
> *docker image 支持X86 and ARM64/ARM32*

## 更新日志

**2023-03-27** 更新frpc为`0.48.0`版本  
**2021-02-05** 更新frpc为`0.39.0`版本  
**2022-12-29** 更新frpc为`0.38.0`版本  
**2021-09-26** 增加ARM32架构支持  
**2021-05-31** 更新国内镜像方便使用  
**2021-05-31** 目前 X86 群晖 DMS 7.0 可直接使用 Linux 版本脚本,已实测.由于没有 ARM 版可尝试,请自行尝试.  
**2021-05-31** 更新 Linux 一键安装脚本同时支持 X86 和 ARM  
**2021-05-29** 更新从`0.36.2`版本起 docker 镜像同时支持 X86 和 ARM

## 计划
**1、** 编写一键安装Docker脚本，以及支持自定义Frpc参数  
**2、** 修改Frpc的配置文件到宿主机保存  
**3、** 增加fprs服务端分支  
**4、** 整合fpr服务端及客户端到一个Docker中  

## 使用说明
以下分为四种部署方法,请根据实际情况自行选择:
- 群晖 NAS docker 安装 **[支持 docker 的群晖机型首选]** [点击查看教程](https://www.ioiox.com/archives/26.html)
- 群晖 NAS 一键脚本安装 **[不支持 docker 的群晖机型]** [点击查看教程](https://www.ioiox.com/archives/6.html)
- Linux 服务器 一键脚本安装 **[内网 Linux 服务器或虚拟机]**
  - 安装Docker
    - ```
      curl -fsSL https://get.docker.com | sh
      # 设置开机自启
      sudo systemctl enable docker.service
      # 根据实际需要保留参数start|restart|stop
      sudo service docker start|restart|stop
      ```
  - 执行下面的命令创建配置文件的目录和文件
    - ```shell
      mkdir /opt/frp
      cd /opt/frp
      echo "[common]">>/opt/frp/frpc.ini
      echo "server_addr = nat.vps.la">>/opt/frp/frpc.ini
      echo "server_port = 7000">>/opt/frp/frpc.ini
      echo "token = nat.vps.la">>/opt/frp/frpc.ini
      ```
    
  - 执行命令拉取并运行容器：
    - docker run -d --name frpc --restart=always -v /opt/frp/frpc.ini:/frp/frpc.ini aircross/frpc_docker
  - 执行命令进入容器：
    - docker exec -it frpc sh
  - 根据实际情况修改配置文件：
    - vi /opt/frp/frpc.ini
  - FPRS服务端：
    - server_addr = nat.vps.la
  - FRPS服务端对接Token：
    - token = nat.vps.la
  - 修改完成后执行下面的命令重启容器生效：
    - docker restart frpc
  
- Linux 服务器 docker 安装 **[内网 Linux 服务器或虚拟机]**
- 默认使用的服务器是：nat.vps.la

### Linux 服务器 一键脚本安装
> *本脚本目前同时支持 Linux X86 和 ARM 架构*

安装
```shell
wget https://raw.githubusercontent.com/aircross/frpc/master/frpc_linux_install.sh && chmod +x frpc_linux_install.sh && ./frpc_linux_install.sh
```

使用
```shell
vi /usr/local/frp/frpc.ini
# 修改 frpc.ini 配置
sudo systemctl restart frpc
# 重启 frpc 服务即可生效
```

卸载
```shell
wget https://raw.githubusercontent.com/aircross/frpc/master/frpc_linux_uninstall.sh && chmod +x frpc_linux_uninstall.sh && ./frpc_linux_uninstall.sh
```

### Linux 服务器 docker 安装
为避免因 **frpc.ini** 文件的挂载,格式或者配置的错误导致容器无法正常运行并循环重启.请确保先配置好 **frpc.ini** 后在运行启动.

先 **git clone** 本仓库,并正确配置 **frpc.ini** 文件.
```shell
git clone https://github.com/aircross/frpc_docker.git
# git clone 本仓库镜像
vi /root/frpc/frpc.ini
# 配置 frpc.ini 文件
```

执行以下命令启动服务
```shell
docker run -d --name=frpc --restart=always -v /root/frpc/frpc.ini:/frp/frpc.ini aircross/frpc_docker
```
> 以上命令 -v 挂载的目录是以 git clone 本仓库为例,也可以在任意位置手动创建 frpc.ini 文件,并修改命令中的挂载路径.

服务运行中修改 **frpc.ini** 配置后需重启 **frpc** 服务.
```shell
vi /root/frp/frpc.ini
# 修改 frpc.ini 配置
docker restart frpc
# 重启 frpc 容器即可生效
```

执行下面的命令进入Docker查看及执行其他命令：
```shell
docker exec -it frpc sh
```
## 版本更新

- latest 为最新版
- Tags 为历史版本

## 相关链接
更多frp相关信息可参考我的博客
- VPS推荐 [VPS.la](https://www.vps.la)
- GitHub [aircross/frpc](https://github.com/aircross/frpc)
- Docker [aircross/frpc](https://hub.docker.com/r/aircross/frpc)
- 原版frp项目 [fatedier/frp](https://github.com/fatedier/frp)
- 原版frp Docker项目 [stilleshan/frpc](https://github.com/stilleshan/frpc)
- [群晖NAS使用Docker安装配置frpc内网穿透教程](https://www.ioiox.com/archives/26.html) 
- [群晖NAS安装配置免费frp内网穿透教程](https://www.ioiox.com/archives/6.html)
- [新手入门 - 详解 frp 内网穿透 frpc.ini 配置](https://www.ioiox.com/archives/79.html)
