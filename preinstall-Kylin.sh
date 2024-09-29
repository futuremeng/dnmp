#!/usr/bin/env bash
###
 # @Author: be_loving@163.com 
 # @Date: 2024-09-11 03:32:36
 # @LastEditors: be_loving@163.com 
 # @LastEditTime: 2024-09-29 08:40:29
 # @FilePath: /dnmp/preinstall-aarch64.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
### 
# 添加阿里云centos 8源
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo
# 添加阿里云docker源
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# 定义yum变量，原因是在麒麟服务器操作系统V10中，$releasever默认是10，而我们需要使用centos8的镜像源，如果不修正，yum会报40X错误。
echo "8" > /etc/yum/vars/centos_version
# 修改repo版本
sed -i 's/$releasever/$centos_version/g' /etc/yum.repos.d/docker-ce.repo
sed -i 's/$releasever/$centos_version/g' /etc/yum.repos.d/CentOS-Base.repo
# 刷新缓存
yum makecache
yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin --allowerasing

cat <<EOF > /etc/docker/daemon.json
{
  "registry-mirrors": [
    "https://quay.mirrors.ustc.edu.cn",
    "https://registry.docker-cn.com",
    "https://docker.m.daocloud.io",
    "https://hub-mirror.c.163.com/",
    "https://dockerhub.icu"
    ],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "1024m",
    "max-file": "10"
  }
}
EOF

systemctl start docker
systemctl enable docker

echo "alias docker-compose='docker compose'" > /etc/profile.d/docker-compose.sh
