FROM golang:latest AS builder

# 容器环境变量添加，会覆盖默认的变量值
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct

WORKDIR /src

# 将服务器的go工程代码加入到docker容器中
COPY . /src

# GOOS:目标系统为linux 
# CGO_ENABLED:默认为1，启用C语言版本的GO编译器，通过设置成0禁用它
# GOARCH:32位系统为386，64位系统为amd64
# -o:指定编译后的可执行文件名称
RUN GOOS=linux CGO_ENABLED=0 GOARCH=amd64 go build -o app

# 运行：使用scratch作为基础镜像
FROM scratch as prod

WORKDIR /svr

# 复制二进制文件到当前工作区
COPY --from=builder /src/app /svr

# Expose port 80 to the outside world
EXPOSE 8000

# Command to run the executable
CMD ["./app"]
