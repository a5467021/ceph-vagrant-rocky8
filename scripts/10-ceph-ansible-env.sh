#! /bin/bash

dnf -y install ansible git python3-netaddr python3-six  # instead of installing from pip directly

cat << EOF >> /etc/ansible/hosts

[mgrs]
master

[monitoring]
master

[rgws]
master

[mons]
master
worker1
worker2
worker3

[osds]
worker1
worker2
worker3
EOF

# git clone https://github.com/ceph/ceph-ansible
cd /opt/ceph-ansible && git checkout stable-6.0

cp site.yml.sample site.yml
# ansible-playbook site.yml
