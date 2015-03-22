#!/bin/bash

work_dir=`pwd`
master_hostname=master
pass=$(openssl passwd vmware) 

sudo vmrun start ${master_hostname}.vmx
sleep 10
sudo vmrun getGuestIPAddress ${master_hostname}.vmx
