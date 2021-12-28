<!--
 * @Date: 2021-12-27 16:20:40
 * @LastEditors: Future Meng
 * @LastEditTime: 2021-12-28 14:00:05
-->
# 建议安装插件
1. jenkins安装时选择默认推荐的插件
2. dingtalk，用来给钉钉群机器人发消息
3. changelog-environment.hpi，用来在shell中获取git更新记录
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