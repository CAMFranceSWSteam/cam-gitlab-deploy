#!/bin/bash
set -x

#variables
gitlabConfFile=/etc/gitlab/gitlab.rb
gitlabConfFileToBePushed=./gitlab.rb
ldapAccountDN=$1
ldapAccountPassword=$2

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

#Backup config file

if [ -f $gitlabConfFile.origin ]; then
cp $gitlabConfFile $gitlabConfFile.origin
fi

#Deploy configuration
_now=$(date +"%m_%d_%Y")
cp $gitlabConfFile $gitlabConfFile.$_now

mv $gitlabConfFileToBePushed $gitlabConfFile

sed -i -e "s/\[\[\[LDAP_ACCOUNT\]\]\]/$ldapAccountDN/" /etc/gitlab/$gitlabConfFile
sed -i -e "s/\[\[\[LDAP_PASSWORD\]\]\]/$ldapAccountPassword/" /etc/gitlab/$gitlabConfFile

gitlab-ctl reconfigure