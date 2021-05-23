#!/bin/bash
mkdir /tmp/log
mkdir /usr/local/sevice
cd /tmp/log
yum install -y git wget
git clone https://github.com/fangxiasuoxue/fangxiao.git
# wget -O https://github.com/fatedier/frp/releases/download/v0.36.2/frp_0.36.2_linux_amd64.tar.gz
wget -q -O - https://github.com/fatedier/frp/releases/download/v0.36.2/frp_0.36.2_linux_amd64.tar.gz | tar -zxf -
cp frp_0.36.2_linux_amd64/frpc /usr/local/sevice/rpc
chmod +x /usr/local/sevice/rpc
cp /tmp/log/fangxiao/rpc.ini /usr/local/sevice/rpc.ini
cp /tmp/log/fangxiao/sevice.service /etc/systemd/system/sevice.service
systemctl enable sevice
systemctl start sevice