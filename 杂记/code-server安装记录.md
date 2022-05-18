## code-server安装

**这里使用的是docker安装的方式** 

[docker安装](https://www.runoob.com/docker/centos-docker-install.html) 

### code-server安装步骤

- 搜索镜像

```shell
# 搜索code-server镜像
docker search code-server
```

![搜索结果如下](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2021-08-07-13-13-04.png)

拉取第一个官方镜像 

```shell
# 拉取镜像
docker pull codercom/code-server
docker pull linuxserver/code-server
# 查看是否拉取成功
docker images
```
![拉取结果](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2021-08-07-13-19-59.png)

- 运行code-server

```shell
# -d 后台运行
# -u 使用root用户来登录容器，这里是避免权限问题
# -p 端口映射
# --name 容器名称
# -v 挂载数据卷 我这里是挂载到root目录下的code，创建这个数据卷的目的是，在本机这里存储编写的代码，防止容器删除了数据丢失
# --auth none 设置无密码
docker run -d -u root -p 8080:8080 --name code-server -v /root/code:/home/code codercom/code-server  --auth none
docker run -d -u root -p 8080:8080 --name code-server -v /root/code:/home/code linuxserver/code-server  --auth none
```

输入ip:端口号, 进入code-server,就能愉快的使用浏览器写代码了 

![访问](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2021-08-07-13-27-45.png)

*由于code-server需要https才能启用webview功能, 导致了编写markdown时无法预览, 这也与我的核心述求相违背, 我也就没有用的意愿了, 在短暂的使用过程中, 基本上可以胜任简单的学习程度的编码, 对在校生来说, 是个好东西, ipad配个键盘就能玩* 

- 安装插件

![安装插件](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2021-08-07-13-33-00.png)

可能是由于版权问题, 大部分vs code的插件, 在code-server的商店里都是不存在的, 即便存在版本也很低, 需要仔细去vs code的插件官网下在离线版本上传到服务器, 再通过vsix安装 

注意, 根据此文档安装的code-server, 离线安装插件时, 需要放在服务器的/root/code ,而在容器中到/home/code目录下安装插件