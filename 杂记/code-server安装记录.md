## code-server 安装

**这里使用的是 docker 安装的方式**

[docker 安装](https://www.runoob.com/docker/centos-docker-install.html)

### code-server 安装步骤

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

- 运行 code-server

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

- 更合理的启动方式

```shell
mkdir -p ~/.config
mkdir -p ~/code-server/project

docker run -d -u root -p 8080:8080 --name code-server -v /root/code:/home/code -v /root/code-server/project:/home/coder/project -v /root/.config:/root/.config codercom/code-server
```

这样配置启动后密码会在`/root/.config/code-server/config.yaml`文件中，密码可以修改

输入 ip:端口号, 输入配置文件中的密码, 进入 code-server,就能愉快的使用浏览器写代码了

![访问](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2021-08-07-13-27-45.png)

使用 **ssh -N -L 8080:127.0.0.1:8080 [user]@[instance-ip]** 命令可以预览 web 视图

_由于 code-server 需要 https 才能启用 webview 功能, 导致了编写 markdown 时无法预览, 这也与我的核心述求相违背, 我也就没有用的意愿了, 在短暂的使用过程中, 基本上可以胜任简单的学习程度的编码, 对在校生来说, 是个好东西, ipad 配个键盘就能玩_

- 安装插件

![安装插件](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2021-08-07-13-33-00.png)

可能是由于版权问题, 大部分 vs code 的插件, 在 code-server 的商店里都是不存在的, 即便存在版本也很低, 需要仔细去 vs code 的插件官网下在离线版本上传到服务器, 再通过 vsix 安装

注意, 根据此文档安装的 code-server, 离线安装插件时, 需要放在服务器的/root/code ,而在容器中到/home/code 目录下安装插件


## 建议使用解压安装的方式，方便使用开发环境

- 配置使用 vscode 原生插件市场地址

rpm安装：编辑文件`/usr/lib/code-server/lib/vscode/product.json`,如果文件中没有这个对象，就新增一个  

解压安装：在解压的安装目录下：`code-server/lib/vscode/product.json`,如果文件中没有这个对象，就新增一个  

```json
  "extensionsGallery": {
    "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
    "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
    "itemUrl": "https://marketplace.visualstudio.com/items",
    "controlUrl": "",
    "recommendationsUrl": ""
  }
```


百度云控制台：
Cockpit 是一个交互式 Linux 服务器管理接口。
https://cockpit-project.org/