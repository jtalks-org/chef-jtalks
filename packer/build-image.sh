#!/bin/sh
rm cookbooks-with-dependencies -r
berks vendor cookbooks-with-dependencies
image_type=$1
account=$2
if [ "$#" -eq 3 ];then
  only="-only $3"
fi

packer build ${only} -var-file=packer/packer-vars-${account}.json packer/packer-${image_type}.json
