# Centos安装Redis

## 一、安装gcc依赖

由于 redis 是用 C 语言开发，安装之前必先确认是否安装 gcc 环境（gcc -v），如果没有安装，执行以下命令进行安装

```bat
yum install -y gcc
```

## 二、下载并解压安装包

```bat
wget http://download.redis.io/releases/redis-5.0.3.tar.gz

tar -zxvf redis-5.0.3.tar.gz
```

## 三、cd切换到redis解压目录下，执行编译

```bat
cd redis-5.0.3

make
```

## 四、安装并指定安装目录

```shell
make install PREFIX=/usr/local/redis
```

## 五、启动

### 5.1、前台启动

```bat
cd /usr/local/redis/bin/

./redis-server
```

### 5.2、后台启动

从 redis 的源码目录中复制 redis.conf 到 redis 的安装目录

```shell
cp /usr/local/redis-5.0.3/redis.conf /usr/local/redis/bin/
```

修改 redis.conf 文件，把 daemonize no 改为 daemonize yes
如果需要远程访问需要把 protected-mode yes 改为 protected-mode yes 同时，注释掉 bind 127.0.0.1

```shell
vi redis.conf
```

![修改daemonize yes](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2020-11-06-19-40-54.png)

后台启动

```shell
./redis-server redis.conf
```

设置远程链接

```shell
# 注释这行
# bind 127.0.0.1
# 修改设置protected-mode为 no
protected-mode no
```

## 六、设置开机启动

添加开机启动服务

```shell
vi /etc/systemd/system/redis.service
```

复制以下内容

```shell
[Unit]
Description=redis-server
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/redis/bin/redis-server /usr/local/redis/bin/redis.conf
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

注意：**ExecStart**配置成自己的路径
设置开机启动

```shell
systemctl daemon-reload

systemctl start redis.service

systemctl enable redis.service
```

创建 redis 命令软链接

```shell
ln -s /usr/local/redis/bin/redis-cli /usr/bin/redis
```

测试 redis  
![测试结果](https://study-note-huang.oss-cn-beijing.aliyuncs.com/img/2020-11-06-19-47-15.png)

### 服务操作命令

```shell
systemctl start redis.service   #启动redis服务

systemctl stop redis.service   #停止redis服务

systemctl restart redis.service   #重新启动服务

systemctl status redis.service   #查看服务当前状态

systemctl enable redis.service   #设置开机自启动

systemctl disable redis.service   #停止开机自启动
```
