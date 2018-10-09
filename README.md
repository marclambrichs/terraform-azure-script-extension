# Terraform Azurerm script extension

This module creates azurerm_virtual_machine_extension resources. To be used together with a compute module.

## Usage
```
module puppet-ext {
  source           = "git@github.com:marclambrichs/terraform-azure-script-extension"
  virtual_machines = ["proxy-0", "es-0", "es-1"]
  name             = "puppet"
  location         = "ukwest'
  resource_group   = "main-rg"
  urls             = ["${azurerm_storage_blob.puppet.url}"]
  command          = "./puppet_bootstrap.sh \"${element(data.terraform_remote_state.state.puppetmaster_ip,0)}\" \"puppetmaster-0\" \"production\""

resource "azurerm_storage_blob" "puppet" {
  name                   = "puppet_bootstrap.sh"
  resource_group_name    = "${var.resource_groupe}"
  storage_account_name   = "${var.storage_account}"
  storage_container_name = "${var.storage_container}"
  type                   = "block"
  source                 = "scripts/puppet_bootstrap.sh"
}
```

Your script in scripts/puppet_bootstrap.sh then could be something like this:
```
#!/bin/env bash

PUPPETMASTER_IP="$1"
PUPPETMASTER_FQDN="$2"
ENV="$3"

echo "kick off puppet..." > /tmp/results.txt

# Install puppet 5 release
echo "Install puppet 5 release..." >> /tmp/results.txt
yum -y install https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

# Install puppet
echo "Install puppet..." >> /tmp/results.txt
yum -y install puppet

# Update local hosts file
echo "${PUPPETMASTER_IP}	${PUPPETMASTER_FQDN}" >> /etc/hosts

# Start puppet service
echo "Start puppet service..." >> /tmp/results.txt
/opt/puppetlabs/bin/puppet agent --server ${PUPPETMASTER_FQDN} --waitforcert 60 --test

echo "bootscript ended..." >> /tmp/results.txt

exit 0
```
