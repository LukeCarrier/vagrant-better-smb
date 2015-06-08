#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

require "vagrant"
require "vagrant-better-smb/plugin"

module VagrantPlugins
  module BetterSmb
    autoload :Caps,   "vagrant-better-smb/caps"
    autoload :Errors, "vagrant-better-smb/errors"

    def self.source_root
      @source_root ||= Pathname.new File.expand_path("../../", __FILE__)
     end
  end
end
