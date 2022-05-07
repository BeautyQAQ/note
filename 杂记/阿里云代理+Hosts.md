### 阿里云自动更新Hosts文件, 解决无法访问GitHub的问题

1.进入[GitHub520](https://github.com/521xueweihan/GitHub520)项目, 里面的hosts文件实时更新, windows、Linux、MAC通用  
2.进入[AUTO_UPDATE_GITHUB_HOSTS](https://github.com/mylovesaber/auto_update_github_hosts)项目([Gitee地址](https://gitee.com/mylovesaber/auto_update_github_hosts))项目, 这里可以配置Linux自动更新hosts文件的脚本  

安装自动更新脚本:  
```shell
# 码云托管的安装脚本 + 指定码云为日用脚本安装源
bash <(wget --no-check-certificate -qO- https://gitee.com/mylovesaber/auto_update_github_hosts/raw/main/setup.sh) -s gitee

# github 托管的安装脚本 + 指定码云为日用脚本安装源
bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/mylovesaber/auto_update_github_hosts/main/setup.sh) -s gitee
```

帮助信息:  
```shell
Github hosts 自动部署和更新工具

命令格式: 
hosts-tool  选项1  (选项2)

选项:

run                        立即更新hosts
updatefrom gitee|github    需指定下载源才能升级该工具
                           可选选项为 gitee 或 github，默认是码云

recover                    该选项将将此工具所有功能从系统中移除
                           可选选项为 first_backup 或 uptodate_backup

help                       显示帮助信息并退出
```

常用命令:  
```shell
# 即时更新 hosts（同时会立即备份 /etc/hosts 中新增的各种dns解析规则）
hosts-tool run

# 即时更新此工具本身
hosts-tool updatefrom gitee

# 完全卸载工具（恢复第一次安装工具时备份的 hosts 文件，会丢弃日后新增的其他各种dns解析规则）
hosts-tool recover first_backup

# 完全卸载工具（恢复最后一次备份的hosts文件，推荐运行此卸载命令前先执行 hosts-tool run）
hosts-tool recover uptodate_backup
```

配置完成之后需要刷新dns:  
```shell
# centos刷新dns  先安装nscd
yum install -y nscd     
systemctl restart nscd
```

### 阿里云代理服务器搭建

1.运行命令

```shell
yum install python-pip
```

2.运行命令

```shell
pip install shadowsocks
```

3.运行命令

```shell
vim /etc/shadowsocks.json
```

4.填入以下内容：

```json
{
"server":"0.0.0.0",
"server_port":12345,
"local_address":"127.0.0.1",
"local_port":1080,
"password":"10086",
"timeout":300,
"method":"aes-256-gcm",
"fast_open":false
}
```

5.输入启动命令

```shell
# 后边跟 & 表示后台启动
ssserver -c /etc/shadowsocks.json &
```

6.在阿里云官网中配置开放8388端口

7.在V2rayN中选择`添加Shadowsocks服务器`，填入对应内容