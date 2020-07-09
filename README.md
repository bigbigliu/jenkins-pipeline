# jenkins-pipeline
Jenkins pipeline + gitlab + docker implement CI / CD function

使用**Jenkins**和**gitlab**实现**golang**项目的自动化构建，**gitlab**打**Tag**，**Webhook**触发**Jenkins**拉代码，在**Jenkins**中编译打包，将镜像推送到Hub仓库，触发远程部署机器拉最新的镜像，运行服务。
