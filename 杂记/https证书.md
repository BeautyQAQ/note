# 基于IP的SSL证书申请-zerossl

1. 进入https://zerossl.com/， 注册账户
2. 选择HTTP File Upload验证。安装好Nginx。 
3. 下载验证文件
4. 将上面下载的验证用txt丢到Nginx的html文件夹即可。
5. nginx的配置如下
```conf
location /.well-known/pki-validation {
    alias  html/;
}
```
6. 配置好后，重启nginx，点击zerossl中验证用的链接，应该能看到`comodoca.com`则验证成功
7. 等待几分钟后，我们会收到证书签发完成的邮件
8. 在配置界面中的Server Type中选择自己的服务端-NGINX，然后点击Download Certificate(.zip)，然后点击Next Step
9. 这里我们先解压得到的证书ZIP，发现三个文件：`ca_bundle.crt`,`certificate.crt`,`private.key`
10. 我们需要将ca_bundle.crt中的内容复制到certificate.crt文件末尾，构成证书链。
11. 之后上传到服务器进行配置，Nginx配置如下

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