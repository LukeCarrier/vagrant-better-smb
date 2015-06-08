#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

module VagrantPlugins
  module BetterSmb
    class SyncedFolder < Vagrant.plugin("2", :synced_folder)
      @@lock = Mutex.new
      def initialize(*args)
      end

      def usable?(machine, raise_error=false)
        installed = machine.env.host.capability(:smb_server_installed)
        raise Errors::SmbServerNotInstalledOnHost if raise_error and !installed

        installed
      end

      def prepare(machine, folders, opts)
        # Pre-boot
      end

      def enable(machine, folders, opts)
        if !machine.guest.capability(:smb_client_installed)
          raise Errors::SmbClientNotInstalledOnGuest
        end

        @@lock.synchronize do
          begin
            machine.env.lock("better-smb-lock") do
              machine.ui.info I18n.t("vagrant_plugins.better_smb.messages.exporting")
              machine.env.host.capability(
                  :smb_folders_export, machine.ui, machine.id, folders)
            end
          rescue Vagrant::Errors::EnvironmentLockedError
            sleep 1
            retry
          end
        end

        machine.ui.info I18n.t("vagrant_plugins.better_smb.messages.mounting")
        machine.guest.capability(:smb_folders_mount, machine, folders)
      end

      def cleanup(machine, opts)
        # Post-halt
      end

      protected

      def addressable_ip
        machine.guest.capability(
            :choose_addressable_ip_addr, candidate_ips)
      end
    end
  end
end
