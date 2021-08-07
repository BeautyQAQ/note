code-server安装:
https://blog.csdn.net/weixin_44852935/article/details/113177886


启动docker命令:
http://scz.617.cn:8/

docker run -d -u root -p 8080:8080 --name code-server -v /root/code:/home/code -e PASSWORD=123456 codercom/code-server  --auth password


docker run -itd --name my-code -u root -p 8086:8080 -v /data/my-code:/home/coder/project -e PASSWORD=123456 codercom/code-server:latest --auth password
