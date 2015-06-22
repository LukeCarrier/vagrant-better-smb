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
      class Linux
        SAMBA_CONF    = "/etc/samba/smb.conf"
        SAMBA_ETC_DIR = "/etc/samba"
        SAMBA_SMBD    = "/usr/sbin/smbd"

        SMBD_STATUS_COMMAND  = "systemctl status smb"
        SMBD_START_COMMAND   = "systemctl start smb"
        SMBD_RESTART_COMMAND = "systemctl restart smb"

        def self.smb_folders_export(env, ui, id, folders)
          config = share_config(Process.uid, id, folders)

          sudo_command = ""
          sudo_command = "sudo " unless File.writable?(SAMBA_CONF)

          cleanup_exports(id)

          config.split("\n").each do |line|
            line = Vagrant::Util::ShellQuote.escape(line, "'")
            system(%Q[echo '#{line}' | #{sudo_command}tee -a #{SAMBA_CONF} >/dev/null])
          end

          if smb_running?
            restart_smb
          else
            start_smb
          end
        end

        def self.smb_folders_prune(env, ui, valid_ids)
          return unless File.exist?(SAMBA_CONF)

          output = false
          user = Process.uid

          File.read(SAMBA_CONF).lines.each do |line|
            if id = line[/^# VAGRANT-BEGIN:( #{user})? ([\.\/A-Za-z0-9\-_:]+?)$/, 2]
              unless valid_ids.include?(id)
                if !output
                  # We want to warn the user but we only want to output once
                  ui.info I18n.t("vagrant_plugins.better_smb.messages.pruning")
                  output = true
                end

                cleanup_exports(id)
              end
            end
          end
        end

        def self.smb_server_installed(env)
          File.directory?(SAMBA_ETC_DIR) &&
              File.file?(SAMBA_CONF) &&
              File.file?(SAMBA_SMBD)
        end

        protected

        def self.cleanup_exports(id)
          return unless File.exist?(SAMBA_CONF)

          sudo_command = ""
          sudo_command = "sudo " unless File.writable?(SAMBA_CONF)

          user = Regexp.escape(Process.uid.to_s)
          id   = Regexp.escape(id.to_s)

          # Use sed to just strip out the block of code which was inserted
          # by Vagrant
          command = "#{sudo_command}sed -r -e '\\\x01^# VAGRANT-BEGIN:( #{user})? #{id}\x01,\\\x01^# VAGRANT-END:( #{user})? #{id}\x01 d' -i.bak #{SAMBA_CONF}"
          system(command)
        end

        def self.share_config(uid, id, folders)
          export_template = File.expand_path(
              "templates/smb/linux_share", BetterSmb.source_root)

          Vagrant::Util::TemplateRenderer.render(
              export_template,
              user: Process.uid,
              uuid: id,
              folders: folders)
        end

        def self.smb_running?
          system "#{SMBD_STATUS_COMMAND} >/dev/null"
        end

        def self.restart_smb
          system "sudo #{SMBD_RESTART_COMMAND} >/dev/null"
        end

        def self.start_smb
          system "sudo #{SMBD_START_COMMAND} >/dev/null"
        end
      end
    end
  end
end
