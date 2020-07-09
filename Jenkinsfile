node {
    stage('Source') {
        // clone代码
        git branch: 'master', credentialsId: 'e4b3479e-d467-4210-80f0-ef401c9b45a2', url: 'git@gitlab.com:bigbigliu/echotest.git'

        def container_name = 'test'

        // 获取tag
        def git_tag = sh(script: 'git describe --always --tag', returnStdout: true).trim() + '_manual_' + env.BUILD_NUMBER

        container_full_name = container_name + '-' + git_tag

        repository = 'registry.cn-zhangjiakou.aliyuncs.com/bigbigliu/' + container_name + ':' + git_tag

        println container_full_name　// 打印镜像全名

        println repository

        // 成功之后返回信息给gitlab
        updateGitlabCommitStatus(name: env.STAGE_NAME, state: 'success')
                script{
                    env.BUILD_TASKS += env.STAGE_NAME + "√..." + env.TAB_STR
                }
    }

    stage('Test') {
        echo "test stage"
    }

    stage('Build') {
        // 登录镜像, 'ali_docker_registry'为jenkins 里配置hub仓库的全局凭证，用这个可以登录镜像仓库
        docker.withRegistry('https://registry.cn-zhangjiakou.aliyuncs.com', 'ali_docker_registry') {
            def customImage = docker.build(repository)
            customImage.push()

            // 清理构建现场
            sh 'docker images | grep test | awk \'{print $1":"$2}\' | xargs docker rmi -f || true'

            // 删除untagged images，也就是那些id为<None>的image的话可以用
            sh 'docker rmi -f  `docker images | grep \'<none>\' | awk \'{print $3}\'` || true'
        }
    }

    stage('deploy') {
        // 配置远程部署主机ssh凭证
        withCredentials([usernamePassword(credentialsId: 'pro4_ssh', passwordVariable: 'password', usernameVariable: 'userName')]) {

        def remote = [:]
        remote.name = 'pro4_ssh'
        remote.user = userName
        remote.host = '39.100.100.240'
        remote.password = password
        remote.allowAnyHosts = true

        writeFile file: 'poll.sh', text: """
        docker ps | grep test | awk '{print \$2}' >> /root/data/jenkins/test_history
        echo /root/data/jenkins/test_history
        docker ps | grep test | awk '{print \$1}' | xargs docker kill || true
        docker images | grep test | awk '{print \$1":"\$2}' | xargs docker rmi -f || true
        docker login --username=yourName --password=yourPassword registry.cn-zhangjiakou.aliyuncs.com
        docker pull ${repository}
        docker run -p 8003:8000 -d ${repository}
        """

        sshPut remote: remote, from: 'poll.sh', into: '.'
        sshScript remote: remote, script: 'poll.sh'
        sshRemove remote: remote, path: 'poll.sh'
        }
        
        echo "Success"
    }

}
