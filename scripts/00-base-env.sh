#! /bin/bash
sed -e 's/^mirrorlist/#mirrorlist/g' -i /etc/yum.repos.d/Rocky-*.repo
sed -e 's/^#baseurl/baseurl/g' -i /etc/yum.repos.d/Rocky-*.repo
sed -e 's@dl.rockylinux.org/$contentdir@mirrors.sjtug.sjtu.edu.cn/rocky@g' -i /etc/yum.repos.d/Rocky-*.repo
# dnf -y update
dnf -y install epel-release yum-utils podman

# Docker repo for CentOS 8; however unnecessary as ceph-ansible hardcodes to use padman, which is shipped with CentOS 8 as default.
# yum-config-manager --add-repo https://mirror.tuna.tsinghua.edu.cn/docker-ce/linux/centos/docker-ce.repo
