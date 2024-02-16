#!/bin/bash

# stop the VM after applying all the changes

# go to the disk section of the VM and select the only disk present

# select the export option on disk page and start export

# you will get a download URL for the .VHD image

# Create a CDI Data Volume in Cluster having kubevirt cluster

# create the VM(VMI) with the above data volume

# Verify VMI is up using virtctl console 

# stop the VM using virtctl(don't delete)

# apply VM export spec, will create a export url for the data volume in .img format

# download this exported image download using wget

# convert this .img image to .qcow2 image

# resize the disk size for qcow2 ~100GB

# create containerd disk image using qcow2 image

# upload this containerd disk image in ecr with new tags
