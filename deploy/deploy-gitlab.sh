#!/bin/bash

#Source https://about.gitlab.com/installation/#centos-7

sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld

#Adding GitLab Repository
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

#Install GitLab using URL from Args
sudo EXTERNAL_URL="$1" yum install -y gitlab-ce