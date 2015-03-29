#!/bin/bash

work_dir=`pwd`
node_prefix=node_0
etcd_host=${1-127.0.0.1}
pass=$(openssl passwd vmware) 

for i in 1 2 3;
do
  node_host=${node_prefix}${i}
  echo "Building node ${node_host}"
  cp ../coreos_image/coreos_production_vmware_image.vmdk ${node_host}_image.vmdk
  sed "s|PASSWD|${pass}|g;s/VM_HOST/${node_host}/g;s/\<master-private-ip\>/$etcd_host/g" ../node.yaml > ${node_host}_cloud_init.yaml
  sed "s/VM_HOST/${node_host}/g;s|WORK_DIR|${work_dir}|g" ../vm_tmpl.vmx > ${node_host}.vmx
  mkdir -p /tmp/new-drive/openstack/latest
  cp ${node_host}_cloud_init.yaml /tmp/new-drive/openstack/latest/user_data
  mv ${work_dir}/${node_host}.iso ${work_dir}/${node_host}.iso.bak
  hdiutil makehybrid -iso -joliet -joliet-volume-name "config-2" -o ${work_dir}/${node_host}.iso /tmp/new-drive
  vmrun start ${node_host}.vmx nogui
  sleep 10
  vmrun getGuestIpAddress ${master_hostname}.vmx
done
