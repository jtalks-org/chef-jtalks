#!/bin/sh
rm cookbooks-with-dependencies -r
berks vendor cookbooks-with-dependencies
app=$1

if [ "${app}" == "db" ];then
  packer_file="packer/packer-db.json"
else
  packer_file="packer/packer-webapp.json"
fi
packer build -var-file=packer/packer-vars-${app}.json ${packer_file}