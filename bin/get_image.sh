#!/bin/bash
cd ../coreos_image
wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_vmware_image.vmdk.bz2
bunzip2 coreos_production_vmware_image.vmdk.bz2
