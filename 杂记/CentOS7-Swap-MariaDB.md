### 开启虚拟内存
1.查看磁盘使用情况
```shell
free -h 
```

2、添加Swap分区
使用dd命令创建名为swapfile 的swap交换文件（文件名和目录任意）:
```shell
dd  if=/dev/zero  of=/var/swapfile  bs=1024  count=4194304 
```

3、对交换文件格式化并转换为swap分区
```shell
mkswap  /var/swapfile
```

4、挂载并激活分区
```shell
swapon   /var/swapfile
```
执行以上命令可能会出现：“不安全的权限 0644，建议使用 0600”类似提示，不要紧张，实际上已经激活了，可以忽略提示，也可以听从系统的建议修改下权限：
```shell
chmod -R 0600 /var/swapfile
```

5、查看新swap分区是否正常添加并激活使用
```shell
free -h 
```

6.下面我们查看当前的swappiness数值：
```shell
cat /proc/sys/vm/swappiness
```

7.修改swappiness值，这里以10为例：
```shell
sysctl vm.swappiness=10
```

8.设置永久有效，重启系统后生效
```shell
echo "vm.swappiness = 10"  >>  /etc/sysctl.conf
```

9.swap分区的删除:停止正在使用swap分区
```shell
swapoff  /var/swapfile
```


10.删除swap分区文件
```shell
rm -rf   /var/swapfile
```

11.删除或注释掉我们之前在fstab文件里追加的开机自动挂载配置内容
```shell
vim    /etc/fstab

#把下面内容删除
/var/swapfile   swap  swap  defaults  0  0
```

### centos7安装自带的mariadb

安装
```shell
yum -y install mariadb mariadb-server
```

启动
```shell
systemctl start mariadb
```

开机自启
```shell
systemctl enable mariadb
```

配置安全策略
```shell
mysql_secure_installation
# 首先设置密码，会提示先输入密码
# Enter current password for root (enter for none):<–初次运行直接回车

# 设置密码
# Set root password? [Y/n] <– 是否设置root用户密码，输入y并回车或直接回车
# New password: <– 设置root用户的密码
# Re-enter new password: <– 再输入一次你设置的密码

# 其他配置
# Remove anonymous users? [Y/n] <– 是否删除匿名用户，回车
# Disallow root login remotely? [Y/n] <–是否禁止root远程登录,回车,
# Remove test database and access to it? [Y/n] <– 是否删除test数据库，回车
# Reload privilege tables now? [Y/n] <– 是否重新加载权限表，回车
```

登录
```shell
mysql -uroot -p    # <– 回车后输入密码
```

配置远程登录
```shell
# 1、进入mysql数据库
use mysql;
# 2、查看权限情况
select host,user,password from user;
# 3、基于用户
grant all privileges on *.* to root@'%'identified by 'root';
# 4、基于IP
grant all privileges on *.* to 'root'@'192.168.0.4'identified by '123456' with grant option;
# 5、刷新权限
flush privileges;
```
