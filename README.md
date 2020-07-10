# jenkins-pipeline
Jenkins pipeline + gitlab + docker implement CI / CD function

使用**Jenkins**和**gitlab**实现**golang**项目的自动化构建，**gitlab**打**Tag**，**Webhook**触发**Jenkins**拉代码，在**Jenkins**中编译打包，将镜像推送到**Hub**仓库，触发远程部署机器拉最新的镜像，运行服务。

- **Docker** ：
- **Jenkins** ：
- **Gitlab** ：
- **Webhook** ：

-------------------

[TOC]

## Docker 安装
### Linux 安装
### Win10 WSL2安装
### Docker镜像加速
阿里云容器Hub服务提供了官方的镜像站点加速官方镜像的下载速度(注册账号就可以免费使用)
#### 一. 获取阿里云镜像加速地址
登录阿里云控制台[容器Hub服务](https://cr.console.aliyun.com/cn-zhangjiakou/instances/repositories)，获取阿里云为你分配的镜像加速地址
![enter image description here](https://s1.ax1x.com/2020/07/10/UMtwyF.png)
#### 二. 配置Docker镜像加速
## Jenkins 安装
## Gitlab 安装
## pipeline 构建