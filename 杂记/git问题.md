## 配置

1.配置邮箱

```shell
git config --global user.name "huangshen"
git config --global user.email  "1426887150@qq.com"
```

2.进入ssh页面查看·

```shell
cd ~/.ssh
ls
```

3.生产SSH Key

```shell
ssh-keygen -t rsa -C "1426887150@qq.com"
```

4.拷贝秘钥 ssh-rsa开头

```shell
cat id_rsa.pub
```

5.测试

```shell
ssh -T git@github.com
//运行结果出现类似如下
Hi xiangshuo1992! You've successfully authenticated, but GitHub does not provide shell access.
```

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

3.输入（注意版本号）:  
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


## 设置代理

1.http || https协议

```shell
#设置全局代理
#http
git config --global https.proxy http://127.0.0.1:port
#https
git config --global https.proxy https://127.0.0.1:port

#使用socks5代理的 例如ss，ssr 1080是windows下ss的默认代理端口,mac下不同，或者有自定义的，根据自己的改
git config --global http.proxy socks5://127.0.0.1:port
git config --global https.proxy socks5://127.0.0.1:port

#只对github.com使用代理，其他仓库不走代理
git config --global http.https://github.com.proxy socks5://127.0.0.1:port
git config --global https.https://github.com.proxy socks5://127.0.0.1:port
#取消github代理
git config --global --unset http.https://github.com.proxy
git config --global --unset https.https://github.com.proxy

//取消全局代理
git config --global --unset http.proxy
git config --global --unset https.proxy
```

2.SSH协议

```shell
#对于使用git@协议的，可以配置socks5代理
#在~/.ssh/config 文件后面添加几行，没有可以新建一个
#socks5
Host github.com
User git
ProxyCommand connect -S 127.0.0.1:port %h %p

#http || https
Host github.com
User git
ProxyCommand connect -H 127.0.0.1:port %h %p
```