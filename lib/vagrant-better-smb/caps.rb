#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

module VagrantPlugins
  module BetterSmb
    module Caps
      autoload :Linux,   "vagrant-better-smb/caps/linux"
      autoload :Windows, "vagrant-better-smb/caps/windows"
    end
  end
end
