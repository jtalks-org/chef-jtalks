#!/bin/sh
packer_file=$1
rm cookbooks-with-dependencies -r
berks vendor cookbooks-with-dependencies
packer build -var-file=packer/vars.json packer/${packer_file}.json