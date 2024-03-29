name: Master-Build-Docker-Images

#on:
#  push:
#    # 每次 push tag 时进行构建，不需要每次 push 都构建。使用通配符匹配每次 tag 的提交，记得 tag 名一定要以 v 开头
#    tags:
#      - v*

on:
  push:
    branches:
      - master

jobs:
  push:
    # 如果需要在构建前进行测试的话需要取消下面的注释和上面对应的 test 动作的注释。
    # needs: test

    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v1
        with:
          java-version: 11
      # 安装maven依赖
      - name: Maven Clean Install
        run: |
          echo '=====开始mvn clean====='
          mvn clean

          echo '=====开始mvn install&&package====='
          mvn install -DskipTests=true && mvn package -DskipTests=true

        # 构建镜像，指定镜像名
      - name: Build Java Docker Images
        run: |

          echo '=====开始构建镜像====='
          echo '=====开始构建how_article====='
          cd how_article
          mvn docker:build
          cd ..

          echo '=====how_base====='
          cd how_base
          mvn docker:build
          cd ..

          echo '=====how_friend====='
          cd how_friend
          mvn docker:build
          cd ..

          echo '=====how_gateway_manager====='
          cd how_gateway_manager
          mvn docker:build
          cd ..

          echo '=====how_gateway_web====='
          cd how_gateway_web
          mvn docker:build
          cd ..

# echo '=====how_gathering====='
# cd how_gathering
# mvn docker:build
# cd ..

          echo '=====how_qa====='
          cd how_qa
          mvn docker:build
          cd ..

          echo '=====how_sms====='
          cd how_sms
          mvn docker:build
          cd ..

          echo '=====how_spit====='
          cd how_spit
          mvn docker:build
          cd ..

          echo '=====how_user====='
          cd how_user
          mvn docker:build
          cd ..

          echo '=====镜像构建结束====='

      # 登录到 阿里云镜像服务，使用 GitHub secrets 传入账号密码，密码被加密存储在 GitHub 服务器
      - name: Login to Aliyun
        uses: docker/login-action@v1
        with:
          registry: registry.cn-beijing.aliyuncs.com
          username: ${{ secrets.ALIYUN_USER_NAME }}
          password: ${{ secrets.ALIYUN_PASSWORD }}

      - name: Push Docker Image
        run: |
          echo '=====开始上传镜像====='
          echo '=====开始上传how_article====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_article

          echo '=====开始上传how_base====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_base

          echo '=====开始上传how_friend====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_friend

          echo '=====开始上传how_gateway_manager====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_gateway_manager

          echo '=====开始上传how_gateway_web====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_gateway_web

# echo '=====开始上传how_gathering====='
# docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_gathering

          echo '=====开始上传how_qa====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_qa

          echo '=====开始上传how_sms====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_sms

          echo '=====开始上传how_spit====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_spit

          echo '=====开始上传how_user====='
          docker push registry.cn-beijing.aliyuncs.com/liushao-repository/how_user

          echo '=====镜像上传结束====='