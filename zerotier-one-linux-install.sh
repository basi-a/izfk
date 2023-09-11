#!/bin/bash

NetworkID=""
DV_SAVE=$(cat /etc/debian_version)

if [ "$DV_SAVE" == "kali-rolling" ]; then
  # Pretend we're Debian buster
  echo testing | sudo tee /etc/debian_version >/dev/null
  # Follow ZeroTier install instructions from:
  # https://www.zerotier.com/download/
  # For example, if you don't care about checking gpg signatures:
  curl -s https://install.zerotier.com | sudo bash
  # Restore /etc/debian-version
  echo "$DV_SAVE" | sudo tee /etc/debian_version >/dev/null
fi

if [ $? -eq 0 ]; then
  sudo systemctl enable zerotier-one --now
fi

zerotier_info=$(sudo zerotier-cli info)
if [[ $zerotier_info == *"200"* ]]; then
  sudo zerotier-cli join "$NetworkID"
fi

if [ $? -eq 0 ]; then
  echo "加入成功,等待授权"
  echo "授权完成后,运行以下命令获取本机在zerotier网络中的IP"
  command="ip addr | grep ztr | grep inet | awk '{print \$2}' | awk -F\"/\" '{print \$1}'"
  echo "$command"
fi

cat >zerotier_leave_and_join.sh<EOF
#!/bin/bash
zerotier_leave(){
sudo zerotier-cli leave ${NetworkID}
}
zerotier_join(){
sudo zerotier-cli join ${NetworkID}
}
EOF
if [ $? -eq 0 ]; then
echo "source $(pwd)/zerotier_leave_and_join.sh" >> ${HOME}/.zshrc
echo "重启或source $HOME/.zshrc"
echo "退出网络 zerotier_leave"
echo "加入网络 zerotier_join"
fi
