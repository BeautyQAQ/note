import os
import nmap

nm = nmap.PortScanner()
ping_raw = nm.scan(hosts="192.168.3.0/24", arguments="-sn")
host_list_ip = [] 


for result in ping_raw['scan'].values():  #将scan下面的数值赋值给result，并开始遍历。
    if result['status']['state'] == 'up':  #如果是up则表明对方主机是存活的。
        host_list_ip.append(result['addresses']['ipv4'])   #在addresses层下的ipv4，也就是IP地址添加到result字典中。

for host in host_list_ip:
    print(host)