#!/bin/bash

prefix=node_0
host_list=${@-"node_01 node_02 node_03"}

# I would love to know how to remove the VM from the
# virtual machine library
for node_host in $host_list 
do
    echo "stopping and deleting ${node_host}"
    vmrun stop ${node_host}.vmx
    rm -rf ${node_host}.vmx.lck
    vmrun deleteVM ${node_host}.vmx
    rm -f ${node_host}.iso
    rm -f ${node_host}_image.vmdk
    rm -f ${node_host}.vmxf
    rm -f ${node_host}.vmsd
    rm -f ${node_host}.plist
    rm -f ${node_host}-*.vmem
    rm -f ${node_host}-*.vmss
done
