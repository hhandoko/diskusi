# -*- mode: ruby -*-
# vi: set ft=ruby :

###
# File     : Vagrantfile
# License  :
#   Copyright (c) 2017 Herdy Handoko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# Notes    :
#   If you change the host IP address or the DB name below, ensure the
#   configuration found under `config/` are updated to match as well.
###

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
# Guest VM(s) configuration
# ~~~~~~
CFG_MEM_SIZE  = ENV['NODE_MEM'] || "1024"          # Configured guest VM memory
CFG_CPU_COUNT = ENV['NODE_CPU'] || "1"             # Configured guest VM CPU core count
CFG_IP        = ENV['NODE_IP']  || "192.168.10.20" # Configured guest VM IP address

# Initialise Vagrant and services constants
# ~~~~~~
VAGRANTFILE_API_VERSION = "2"                      # Vagrant API / syntax version
POSTGRESQL_VERSION      = "9.6"                    # PostgreSQL version
APP_DB_USER             = "diskusi_user"           # PostgreSQL username
APP_DB_PASS             = "S3cret!"                # PostgreSQL user password
APP_DB_NAME             = "diskusi_data"           # Application database name (prefix)



# -----------------------------------------------------------------------------
# Vagrant Script
# -----------------------------------------------------------------------------
# VM provisioning
# ~~~~~~
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu 14.04 LTS (Trusty Tahr) image from Hashicorp repository
  config.vm.box = "ubuntu/trusty64"

  # Use `vagrant-cachier` to cache common packages and reduce time to provision boxes.
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  # Create a private network connection with the defined IP address
  config.vm.network :private_network, ip: CFG_IP

  # PostgreSQL Provisioning via shell script
  config.vm.provision :shell do |s|
    s.path = "tools/vagrant/postgresql.sh"
    s.env  = {
        "HOST_IP" => CFG_IP,
        "PG_VERSION" => POSTGRESQL_VERSION,
        "APP_DB_USER" => APP_DB_USER,
        "APP_DB_PASS" => APP_DB_PASS,
        "APP_DB_NAME" => APP_DB_NAME
    }
  end

  # Provider-specific configuration to fine-tune Vagrant backing providers.
  # ~~~~~~
  # VMware Workstation-specific configuration
  config.vm.provider :vmware_workstation do |vm|
    vm.vmx["memsize"]  = CFG_MEM_SIZE
    vm.vmx["numvcpus"] = CFG_CPU_COUNT
  end

  # VMware Fusion-specific configuration
  config.vm.provider :vmware_fusion do |vm|
    vm.vmx["memsize"]  = CFG_MEM_SIZE
    vm.vmx["numvcpus"] = CFG_CPU_COUNT
  end

  # VirtualBox-specific configuration
  config.vm.provider :virtualbox do |vm|
    vm.customize ["modifyvm", :id, "--memory", CFG_MEM_SIZE]
    vm.customize ["modifyvm", :id, "--cpus"  , CFG_CPU_COUNT]
  end
end
