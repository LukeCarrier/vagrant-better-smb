#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

module VagrantPlugins
  module BetterSmb
    class Plugin < Vagrant.plugin("2")
      name "BetterSmb"
      description "Better SMB support for Vagrant"

      host_capability :linux, :smb_folders_export do
        init!
        Caps::Linux
      end

      host_capability :linux, :smb_folders_prune do
        init!
        Caps::Linux
      end

      host_capability :linux, :smb_server_installed do
        init!
        Caps::Linux
      end

      guest_capability :windows, :smb_client_installed do
        init!
        Caps::Windows
      end

      guest_capability :windows, :smb_folders_mount do
        init!
        Caps::Windows
      end

      synced_folder :better_smb, 1 do
        init!

        require_relative "synced_folder"
        SyncedFolder
      end

      action_hook :better_smb_prepare_valid_ids, :machine_action_up do |hook|
        init!

        require_relative "action_prepare_valid_ids"
        hook.append(ActionPrepareValidIDs)
      end

      action_hook :better_smb_prune, :machine_action_halt do |hook|
        init!

        require_relative "action_prepare_valid_ids"
        require_relative "action_prune"
        hook.append(ActionPrepareValidIDs)
        hook.after(ActionPrepareValidIDs, ActionPrune)
      end

      protected

      def self.init!
        return if defined?(@initialized)

        I18n.load_path << File.expand_path(
            "templates/locales/better_smb.yml", BetterSmb.source_root)
        I18n.reload!
        @initialized = true
      end
    end
  end
end
