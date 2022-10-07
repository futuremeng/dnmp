<!--
 * @Date: 2021-12-27 16:20:40
 * @LastEditors: Future Meng
 * @LastEditTime: 2022-01-07 10:40:22
-->
# 建议安装插件
1. jenkins安装时选择默认推荐的插件
2. dingtalk，用来给钉钉群机器人发消息
3. changelog-environment.hpi，用来在shell中获取git更新记录,可以通过插件管理中的高级-上传插件方式安装，文件在./services/jenkins中可以获得
4. Generic Webhook Trigger，用来接收针对某个项目的触发请求

## 全局工具配置 configureTools

### JDK
新增JDK
1. 别名：openjdk
2. JAVA_HOME：/opt/java/openjdk（通过docker exec -it jenkins /bin/bash进入jenkins容器，echo $JAVA_HOME查询）

java -version
openjdk version "11.0.13" 2021-10-19
OpenJDK Runtime Environment Temurin-11.0.13+8 (build 11.0.13+8)
OpenJDK 64-Bit Server VM Temurin-11.0.13+8 (build 11.0.13+8, mixed mode)

### MAVEN
新增Maven
1. 设置Name：maven
2. 勾选自动安装，默认可以选择从Apache安装3.8.4，保存 
3. 安装插件：Maven Integration

### Nodejs
新增Nodejs
1. 安装插件Nodejs
2. 在全局工具配置中添加Nodejs，设置别名，如nodejs17.3.0，自动安装
3. 在Job Item中勾选Provide Node & npm bin/ folder to PATH，Cache location选择Local to the executor，可以将执行位置放到当前项目下
4. 在Job Item中设置构建shell，如npm install、npm run build等

### 内存不足
在docker-compose的jenkins中增加如下配置：

deploy:
  resources:
    limits:
      memory: 2G
    reservations:
      memory: 200M

并使用
```
docker-compose --compatibility up -d jenkins
```
启动

使用
```docker stats```
确认内存占用情况

## 二级目录部署

JENKINS_OPTS: '--prefix=/jenkins'

```


  jenkins:
    image: jenkins/jenkins:${JENKINS_VERSION}
    container_name: jenkins
    volumes:
        - ${JENKINS_HOME_DIR}:/var/jenkins_home
        - ${JENKINS_CERTS_DIR}:/certs/client
        - ${SOURCE_DIR}:/www/:rw
        - ${TOMCAT_WEBAPPS_DIR}:/webapps/:rw
        - /var/run/docker.sock:/var/run/docker.sock
        - /usr/bin/docker:/usr/bin/docker
        - /usr/lib/x86_64-linux-gnu/libltdl.so.7:/usr/lib/x86_64-linux-gnu/libltdl.so.7
    ports:
        - "${JENKINS_HTTP_PORT}:8080"
        - 50000:50000
    privileged: true
    user: root
    restart: always
    environment:
        TZ: "$TZ"
        JAVA_OPTS: '-Djava.util.logging.config.file=/var/jenkins_home/log.properties'
        JENKINS_OPTS: '--prefix=/jenkins'
    networks:
      - default

```

## nginx

```
    location /jenkins/ {
        proxy_pass http://jenkins:8080/jenkins/;
        # add_header Content-Security-Policy "script-src 'self' 'unsafe-inline' 'unsafe-eval'; object-src 'self'; style-src 'self' 'unsafe-inline';";
        proxy_set_header Host            $host;
        proxy_set_header X-Real-IP       $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

    }
```


## 安装常用插件

Git Parameter
Generic Webhook Trigger
Nodejs

### changelog
在./services/jenkins中获取插件文件
changelog-environment.hpi

在jenkins插件管理的高级页签，通过上传来安装

在job中，勾选Add Changelog Information to Environment
并设置：

Entry Format
%3$s(at %4$s via %1$s)\n

Date Format
yyyy-MM-dd HH:mm:ss

在shell中通过${SCM_CHANGELOG}调用