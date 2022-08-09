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