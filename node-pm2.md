# node-pm2

## 部署

cp ./services/node-pm2/pm2-apps.json.demo ./services/node-pm2/pm2-apps.json



根据实际需要修改其中的app，可以在数据中增加多个app




https://github.com/keymetrics/docker-pm2

Command	Description
$ docker exec -it <container-id> pm2 monit	Monitoring CPU/Usage of each process
$ docker exec -it <container-id> pm2 list	Listing managed processes
$ docker exec -it <container-id> pm2 show	Get more information about a process
$ docker exec -it <container-id> pm2 reload all	0sec downtime reload all applications


docker exec -it node-pm2 pm2 monit