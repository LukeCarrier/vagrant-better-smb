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
      class Windows
        def self.smb_client_installed(env)
          true
        end

        def self.smb_folders_mount(env, machine, folders)
          folders.each do |folder, opts|
            share_name = clean_string opts[:better_smb_share_name]
            guest_path = clean_string opts[:guestpath]
            user       = clean_string opts[:better_smb_share_user]
            password   = clean_string opts[:better_smb_share_password]

            share = "\\\\#{opts[:better_smb_host_ip]}\\#{share_name}"

            auth_command   = "cmdkey /add:#{opts[:better_smb_host_ip]} /user:#{user} /pass:#{password}"
            clean_command  = "NET USE #{guest_path} /DELETE /Y"
            unfuck_command = "NET USE #{share}"
            mount_command  = "NET USE #{guest_path} #{share} /PERSISTENT:yes"

            machine.communicate.execute "#{auth_command} ; #{clean_command} ; #{unfuck_command} ; #{mount_command}", {
                shell: :powershell, elevated: true, error_check: false}
          end
        end

        def self.clean_string(string)
          string.gsub "$", "```$"
        end
      end
    end
  end
end
