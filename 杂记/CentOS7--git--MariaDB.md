### CentOS7升级git版本

CentOS7自带的git版本1.8.3.1太低, vscode会给出警告  
使用`yum update git`命令无法更新成功, 还是1.8  

网上提供的升级方案，其本上都是先删除原来的，然后在官网上下载最新的，自己make，make过程中容易报错，很麻烦。  

新的思路:  

1.切换root账户  
```shell
su root
```

2.配置存储库  
```shell
vim /etc/yum.repos.d/wandisco-git.repo
```

3.输入:  
```shell
[wandisco-git]
name=Wandisco GIT Repository
baseurl=http://opensource.wandisco.com/centos/7/git/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
```
保存退出

4.导入存储库GPG密钥:  
```shell
sudo rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
```

5.安装git:  
```shell
yum install git
```

最后验证版本, 安装成功




### remote: Support for password authentication was removed on August 13, 2021.

解决方案 https://blog.csdn.net/weixin_41010198/article/details/119698015  

忽略上述问题, 仍然使用SSH方式提交  

配置好公钥后:  
1.项目得使用 SSH clone
2.git修改远程仓库地址  
方法有三种:  
```shell
# 修改命令
git remote origin set-url [url]

# 先删后加
git remote rm origin
git remote add origin [url]

# 直接修改config文件
# git文件夹，找到config，编辑，把旧的项目地址替换成新的。
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
         