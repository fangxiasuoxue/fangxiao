#!/bin/bash
echo '开始安装*****'
mkdir /tmp/log
mkdir /usr/local/sevice
cd /tmp/log
# yum install -y git wget
# wget -O https://github.com/fatedier/frp/releases/download/v0.36.2/frp_0.36.2_linux_amd64.tar.gz
# wget -q -O - https://github.com/fatedier/frp/releases/download/v0.36.2/frp_0.36.2_linux_amd64.tar.gz | tar -zxf -
wget -q -O - http://html.pipijiaoyu.com/upload/frp_0.36.2_linux_amd64.tar.gz | tar -zxf -
cp frp_0.36.2_linux_amd64/frpc /usr/local/sevice/rpc
chmod +x /usr/local/sevice/rpc

echo '创建***目录成功'

cat > /usr/local/sevice/rpc.ini << EOF
[common]
server_addr = $1
server_port = $2

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = $3
EOF

echo '配置生成1成功'

# cp /tmp/log/fangxiao/rpc.ini /usr/local/sevice/rpc.ini
# cp /tmp/log/fangxiao/sevice.service /etc/systemd/system/sevice.service

cat > /etc/systemd/system/sevice.service << EOF
[Unit]
Description=Frp Client Service
After=network.target

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/sevice/rpc -c /usr/local/sevice/rpc.ini
ExecReload=/usr/local/sevice/rpc reload -c /usr/local/sevice/rpc.ini

[Install]
WantedBy=multi-user.target
EOF
echo '配置生成2成功'

systemctl enable sevice
systemctl start sevice

echo '启动成功'