#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

Vagrant.configure("2") do |config|
  config.vm.box = "LukeCarrier/windows-2008-r2-64"

  config.vm.network :private_network, ip: "10.10.10.10"

  config.vm.synced_folder "testdata", "T:", type: "better_smb",
                          better_smb_machine_ip: "10.10.10.10",
                          better_smb_share_name: "testdata",
                          better_smb_host_ip: "10.0.2.2",
                          better_smb_share_user: "luke",
                          better_smb_share_password: "scrubbed"
end
