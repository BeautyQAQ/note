### 解决WSL关闭后vmmem程序内存占用过高的问题

#### 原因
wsl2本身的机制会不断地拿宿主机的内存来给自己当cache使用, 并且拿了还不还. 导致vmmem程序占用内存过高

#### 解决方案
1. 重启wsl2
1. 使用.wslconfig文件限制资源
1. 调整内核参数定期释放cache内存

**重启wsl2:**
如果我们直接关闭wsl2的窗口并不会关闭该wsl2的虚拟机, 它依旧会在后台运行, 需要关闭wsl2的话我们可以打开powershell, 在里面使用`wsl --shutdown`命令就可以关闭全部的wsl2虚拟机了. 之后再随意打开一个wsl2的窗口就会再次开启虚拟机.

这种方式释放内存最彻底, 效果和物理机内存不足卡死然后直接重启是一样的. 

**限制wsl2内存使用:**
就是创建一个%UserProfile%\.wslconfig文件来限制wsl使用的内存总量. 比如说我在Windows中使用的用户是huang, 那么我就在C:\Users\huang中创建了一个.wslconfig文件,在里面加入以下内容来限制wsl2的内存总大小:
```shell
[wsl2]
processors=8
memory=8GB
swap=8GB
localhostForwarding=true
```

注意修改完成之后需要重启wsl2才能生效。 更多详细的配置可以查看[官方文档](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#configure-global-options-with-wslconfig)


**定期释放cache内存:**
Linux内核中有一个参数/proc/sys/vm/drop_caches，是可以用来手动释放Linux中的cache缓存, 如果发现wsl2的cache过大影响到宿主机正常运行了,可以手动执行以下命令来释放cache: 
```shell
echo 3 > /proc/sys/vm/drop_caches
```
可以设置成定时任务,每隔一段时间释放一次.

