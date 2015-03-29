#!/bin/bash

master_host=master
# I would love to know how to remove the VM from the
# virtual machine library
echo "stopping and deleting ${master_host}"
vmrun stop ${master_host}.vmx
rm -rf ${master_host}.vmx.lck
vmrun deleteVM ${master_host}.vmx
rm -f ${master_host}.iso
rm -f ${master_host}_image.vmdk
rm -f ${master_host}.vmxf
rm -f ${master_host}.vmsd
rm -f ${master_host}.plist
rm -f ${master_host}-*.vmem
rm -f ${master_host}-*.vmss
