#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

module VagrantPlugins
  module BetterSmb
    module Errors
      class BetterSmbError < Vagrant::Errors::VagrantError
        error_namespace "vagrant_plugins.better_smb.errors"
      end

      class SmbClientNotInstalledOnGuest < BetterSmbError
        error_key :smb_client_not_installed_on_guest
      end

      class SmbServerNotInstalledOnHost < BetterSmbError
        error_key :smb_server_not_installed_on_host
      end
    end
  end
end
