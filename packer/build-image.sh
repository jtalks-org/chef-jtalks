#!/bin/sh
rm cookbooks-with-dependencies -r
berks vendor cookbooks-with-dependencies
image_type=$1
if [ "$#" -eq 2 ];then
  only="-only $2"
fi

packer build ${only} -var-file=packer/packer-vars-${image_type}.json packer/packer-${image_type}.json