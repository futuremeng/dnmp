
# nginx 配置

## release相关

### nginx

Nginx中设置基础认证，需要用户名密码才能访问
```
cd services/nginx/auth
echo  -n 'USRER:' >> .htpasswd
openssl passwd -apr1 PASSWORD >> .htpasswd
```
其中USRER就是用户名，PASSWORD就是密码，请替换为自己设定的信息
.htpasswd是生成的密钥文件，建议命名为项目或相应目录的名称，例如.google.htpasswd

在conf.d的conf文件中，添加设置启用：
location /google {
    auth_basic "authentication";
    auth_basic_user_file /etc/nginx/auth/.google.htpasswd;
}


### jenkins

#### 构建
在构建端的jenkins中

job的shell中：
```
rm -f api.tar.gz

tar -czvf api.tar.gz .[!.]* * --exclude=.git --exclude=api.tar.gz
cp -f api.tar.gz /www/domain/release/client/api.tar.gz

curl 'https://oapi.dingtalk.com/robot/send?access_token=' \
   -H 'Content-Type: application/json' \
   -d "{'msgtype': 'text', 'text': {'content': \"rmt update ${GIT_BRANCH} changelogs:\n${SCM_CHANGELOG}\n https:\/\/domain\/release\/client\/api.tar.gz\"}}"


curl 'http://client/jenkins/generic-webhook-trigger/invoke?token=api'

```

#### 部署
在部署端的jenkins中,
docker exec -it jenkins /bin/bash
apt update
apt install wget


job的shell中：

```
wget --http-user=USRER --http-passwd=PASSWORD https://domain/release/client/api.tar.gz
mkdir client
tar -xzf ./api.tar.gz -C ./client
cp -rf ./client/. /www/client

curl 'https://oapi.dingtalk.com/robot/send?access_token=' \
   -H 'Content-Type: application/json' \
   -d "{'msgtype': 'text', 'text': {'content': \"update  https:\/\/client\/api\/doc\"}}"
```