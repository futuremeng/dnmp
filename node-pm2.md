# node-pm2

## 部署
```
cp ./services/node-pm2/pm2-apps.json.demo ./services/node-pm2/pm2-apps.json
```

根据实际需要修改其中的app，可以在数据中增加多个app


### 设置参数说明

#### name
app启动名称
#### script
脚本文件位置
#### cwd
脚本执行的相对路径
#### -args
脚本执行参数
#### env
脚本执行前设置的环境变量
可以在项目中增加一个.env.pm2的配置文件，并在pm2-apps.json中的env中以一下方式指定。
"NODE_ENV": "pm2"

#### log_file
保存log文件路径
#### error_file
error log文件路径
#### out_file
out log文件路径

作者：rill_
链接：https://www.jianshu.com/p/58197cb2de71
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



https://github.com/keymetrics/docker-pm2

Command	Description
$ docker exec -it <container-id> pm2 monit	Monitoring CPU/Usage of each process
$ docker exec -it <container-id> pm2 list	Listing managed processes
$ docker exec -it <container-id> pm2 show	Get more information about a process
$ docker exec -it <container-id> pm2 reload all	0sec downtime reload all applications


docker exec -it node-pm2 pm2 monit

通过docker-compose expose 3000到3999的端口
在pm2-apps.json中app的port可以指定为3001到3999的端口
则在nginx中可以配置代理到相应的应用的端口，如

```
location /api/ {
        proxy_pass http://node-pm2:3001/;
        # add_header Content-Security-Policy "script-src 'self' 'unsafe-inline' 'unsafe-eval'; object-src 'self'; style-src 'self' 'unsafe-inline';";
        proxy_set_header Host            $host;
        proxy_set_header X-Real-IP       $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    }
```


并使用
```
docker-compose --compatibility up -d node-pm2
```
启动