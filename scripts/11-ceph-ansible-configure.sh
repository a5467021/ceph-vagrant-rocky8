#! /bin/bash

# $1 is supposed to be the root directory of ceph-ansible

conf_all=$1/group_vars/all.yml
conf_osds=$1/group_vars/osds.yml
conf_docker=$1/roles/ceph-container-engine/vars/RedHat.yml

# ========================================

cp $conf_all.sample $conf_all
cat << EOF >> $conf_all

monitor_interface: eth0
radosgw_interface: eth0

ceph_origin: repository
ceph_repository: community
ceph_mirror: https://mirror.tuna.tsinghua.edu.cn/ceph/
ceph_stable_release: pacific
ceph_stable_repo: "{{ ceph_mirror }}/rpm-{{ ceph_stable_release }}"
ceph_stable_redhat_distro: el8

journal_size: 1024
generate_fsid: true

dashboard_admin_user: admin
dashboard_admin_password: p@ssw0rd
grafana_admin_user: admin
grafana_admin_password: p@ssw0rd  # this entry seems to be unused; still need to use default login admin/admin

EOF

# ========================================

cp $conf_osds.sample $conf_osds
cat << EOF >> $conf_osds

osd_auto_discovery: true

EOF

# ========================================

sed -i -e 's/docker$/podman/g' $conf_docker

# Configuring Ceph OSD is damn tricky: the stable-6 branch fails to automatically create lvm-type OSD.
# However, if typing the command into OSD server manually, the configuration of serveral servers seems
# to be chained, e.g. when creating OSD drive on osd3, OSD drive on osd1 is automatically configured and
# NOT accounting to the ceph cluster. In this condition, we can erase the superblock of the partition,
# restart the server and create the OSD device again. In this way, the created OSDs should join the cluster correctly.

# UPDATE 1
# Refer to BUILDING to use `ceph-volume lvm zap` as a more recommemded way to reinitalize OSD disk. 

# ceph-volume lvm create --data /dev/sdb
