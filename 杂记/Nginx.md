## 编译安装nginx。

以下是在Ubuntu上从源代码编译和安装最新版本的nginx的步骤：

1. 安装构建工具和依赖项：

   ```
   sudo apt-get update
   sudo apt-get install build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev
   ```

   `build-essential`是包含GNU C/C++编译器和make工具等必要组件的软件包，`libpcre3`、`zlib1g`和`libssl-dev`则是nginx所需的依赖项。

2. 下载并解压nginx源代码：

   在nginx官网下载tar包：http://nginx.org/en/download.html

   ```
   wget http://nginx.org/download/nginx-1.20.1.tar.gz
   tar zxvf nginx-1.20.1.tar.gz
   ```

3. 进入解压后的目录，并运行如下命令进行配置：

   ```
   cd nginx-1.20.1
   ./configure --prefix=/usr/local/nginx
   ```

   `--prefix`选项指定nginx将安装到哪个目录下，默认为`/usr/local/nginx`。

4. 运行`make`命令：

   ```
   make
   ```

   该命令将编译nginx。

5. 运行`make install`命令：

   ```
   sudo make install
   ```

   该命令将安装nginx。

6. 启动nginx：

   ```
   /usr/local/nginx/sbin/nginx
   ```

   如果你希望以后能够更方便地管理nginx，可以使用systemd来启动它。首先创建一个`nginx.service`文件：

   ```
   sudo nano /lib/systemd/system/nginx.service
   ```

   然后将以下内容复制到文件中：

   ```
   [Unit]
   Description=The NGINX HTTP and reverse proxy server
   After=syslog.target network.target remote_fs.target nss-lookup.target

   [Service]
   Type=forking
   PIDFile=/usr/local/nginx/logs/nginx.pid
   ExecStartPre=/usr/local/nginx/sbin/nginx -t
   ExecStart=/usr/local/nginx/sbin/nginx
   ExecReload=/bin/kill -s HUP $MAINPID
   ExecStop=/bin/kill -s QUIT $MAINPID
   PrivateTmp=true

   [Install]
   WantedBy=multi-user.target
   ```

   保存并关闭文件。然后运行以下命令重新加载systemd配置：

   ```
   sudo systemctl daemon-reload
   ```

   现在，你可以使用以下命令启动nginx：

   ```
   sudo systemctl start nginx
   ```

   如果一切正常，nginx将开始运行，访问IP:80测试。


```conf
ssl_certificate      ./ssl/certificate.crt;
            ssl_certificate_key  ./ssl/private.key;

        ssl_stapling on;
        ssl_stapling_verify on;
        ssl_trusted_certificate ./ssl/certificate.crt;
        resolver 1.1.1.1 1.0.0.1 119.29.29.29 valid=300s;
        resolver_timeout 30s;

        ssl_session_cache    shared:SSL:10m;
        ssl_session_timeout  1d;
        ssl_session_tickets off;

        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305;
        ssl_prefer_server_ciphers on;
```
12. 配置好后重启Nginx，你就可以使用https://ip的形式访问你的服务器了。 
13. 之后回到ZeroSSL，我们点击Check Installation，验证成功则完成。

nginx配置文件备份
```conf

#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    # server {
    #     listen       80;
    #     server_name  localhost;

    #     #charset koi8-r;

    #     #access_log  logs/host.access.log  main;

    #     location / {
    #         root   html;
    #         index  index.html index.htm;
    #     }

    #     location /.well-known/pki-validation {
    #         alias  html/;
    #     }

    #     #error_page  404              /404.html;

    #     # redirect server error pages to the static page /50x.html
    #     #
    #     error_page   500 502 503 504  /50x.html;
    #     location = /50x.html {
    #         root   html;
    #     }

    #     # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #     #
    #     #location ~ \.php$ {
    #     #    proxy_pass   http://127.0.0.1;
    #     #}

    #     # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #     #
    #     #location ~ \.php$ {
    #     #    root           html;
    #     #    fastcgi_pass   127.0.0.1:9000;
    #     #    fastcgi_index  index.php;
    #     #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #     #    include        fastcgi_params;
    #     #}

    #     # deny access to .htaccess files, if Apache's document root
    #     # concurs with nginx's one
    #     #
    #     #location ~ /\.ht {
    #     #    deny  all;
    #     #}
    # }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    server {
       listen       443 ssl;
       server_name  xxx.xx.xxx.xxx;
      # ssl                  on;
       ssl_certificate      /root/ssl/certificate.crt; 
       ssl_certificate_key  /root/ssl/private.key;

       access_log   /var/log/nginx/nginx.vhost.access.log;
       error_log    /var/log/nginx/nginx.vhost.error.log;

        ssl_stapling on;
        ssl_stapling_verify on;
        ssl_trusted_certificate /root/ssl/certificate.crt;
        resolver 1.1.1.1 1.0.0.1 119.29.29.29 valid=300s;
        resolver_timeout 30s;

       ssl_session_cache    shared:SSL:10m;
       ssl_session_timeout  1d;
       ssl_session_tickets off;

        ssl_protocols TLSv1.2 TLSv1.3;
        # ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305;
        # ssl_prefer_server_ciphers on;

       ssl_ciphers  HIGH:!aNULL:!MD5;
       ssl_prefer_server_ciphers  on;

   #    location / {
    #       root   html;
    #       index  index.html index.htm;
    #   }
    
      location / {
      proxy_pass http://localhost:9999/;
      proxy_set_header Host $host;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection upgrade;
      proxy_set_header Accept-Encoding gzip;
      }

     # 使用497状态码检测HTTP请求，自动转换为HTTPS
    error_page 497 https://$host:$server_port$uri$is_args$args;

    }

}








#--------------------------------



# #user  nobody;
# worker_processes  1;

# #error_log  logs/error.log;
# #error_log  logs/error.log  notice;
# #error_log  logs/error.log  info;

# #pid        logs/nginx.pid;


# events {
#     worker_connections  1024;
# }


# http {
#     include       mime.types;
#     default_type  application/octet-stream;

#     #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
#     #                  '$status $body_bytes_sent "$http_referer" '
#     #                  '"$http_user_agent" "$http_x_forwarded_for"';

#     #access_log  logs/access.log  main;

#     sendfile        on;
#     #tcp_nopush     on;

#     #keepalive_timeout  0;
#     keepalive_timeout  65;

#     #gzip  on;

#     server {
#         listen       80;
#         server_name  localhost;

#         #charset koi8-r;

#         #access_log  logs/host.access.log  main;

#         location / {
#             root   html;
#             index  index.html index.htm;
#         }

#         location /.well-known/pki-validation {
#             alias  html/;
#         }

#         #error_page  404              /404.html;

#         # redirect server error pages to the static page /50x.html
#         #
#         error_page   500 502 503 504  /50x.html;
#         location = /50x.html {
#             root   html;
#         }

#         # proxy the PHP scripts to Apache listening on 127.0.0.1:80
#         #
#         #location ~ \.php$ {
#         #    proxy_pass   http://127.0.0.1;
#         #}

#         # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
#         #
#         #location ~ \.php$ {
#         #    root           html;
#         #    fastcgi_pass   127.0.0.1:9000;
#         #    fastcgi_index  index.php;
#         #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
#         #    include        fastcgi_params;
#         #}

#         # deny access to .htaccess files, if Apache's document root
#         # concurs with nginx's one
#         #
#         #location ~ /\.ht {
#         #    deny  all;
#         #}
#     }


#     # another virtual host using mix of IP-, name-, and port-based configuration
#     #
#     #server {
#     #    listen       8000;
#     #    listen       somename:8080;
#     #    server_name  somename  alias  another.alias;

#     #    location / {
#     #        root   html;
#     #        index  index.html index.htm;
#     #    }
#     #}


#     # HTTPS server
#     #
#     #server {
#     #    listen       443 ssl;
#     #    server_name  localhost;

#     #    ssl_certificate      cert.pem;
#     #    ssl_certificate_key  cert.key;

#     #    ssl_session_cache    shared:SSL:1m;
#     #    ssl_session_timeout  5m;

#     #    ssl_ciphers  HIGH:!aNULL:!MD5;
#     #    ssl_prefer_server_ciphers  on;

#     #    location / {
#     #        root   html;
#     #        index  index.html index.htm;
#     #    }
#     #}

# }
```