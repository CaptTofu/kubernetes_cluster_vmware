#!/bin/bash

work_dir=`pwd`
master_hostname=master
pass=$(openssl passwd vmware) 

cp ../coreos_image/coreos_production_vmware_image.vmdk ${master_hostname}_image.vmdk
sed "s|PASSWD|${pass}|g;s/VM_HOST/${master_hostname}/g" ../master.yaml > ${master_hostname}_cloud_init.yaml
sed "s/VM_HOST/${master_hostname}/g;s|WORK_DIR|${work_dir}|g" ../vm_tmpl.vmx > ${master_hostname}.vmx
mkdir -p /tmp/new-drive/openstack/latest
cp ${master_hostname}_cloud_init.yaml /tmp/new-drive/openstack/latest/user_data
mv ${work_dir}/${master_hostname}.iso ${work_dir}/${master_hostname}.iso.bak
hdiutil makehybrid -iso -joliet -joliet-volume-name "config-2" -o ${work_dir}/${master_hostname}.iso /tmp/new-drive

sudo vmrun start ${master_hostname}.vmx
#sudo vmrun getGuestIPAddress ${master_hostname}.vmx
