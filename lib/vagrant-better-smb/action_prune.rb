#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

module VagrantPlugins
  module BetterSmb
    class ActionPrune
      def initialize(app, env)
        @app = app
      end

      def call(env)
        if env[:machine].env.host.capability?(:smb_folders_prune) &&
            env[:better_smb_valid_ids]
          env[:machine].env.host.capability(
              :smb_folders_prune, env[:machine].ui, env[:better_smb_valid_ids])
        end

        @app.call(env)
      end
    end
  end
end
