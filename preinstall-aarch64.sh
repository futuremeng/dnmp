#!/usr/bin/env bash
###
 # @Author: be_loving@163.com 
 # @Date: 2024-09-11 03:32:36
 # @LastEditors: be_loving@163.com 
 # @LastEditTime: 2024-09-11 03:33:03
 # @FilePath: /dnmp/preinstall-aarch64.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
### 
yum -y update
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/aarch64/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io

systemctl start docker
systemctl enable docker

curl -L \
   http://bisheng-public.oss-cn-zhangjiakou.aliyuncs.com/resource/docker/docker-compose  \
   -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
