#
# Better SMB for Vagrant
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

module VagrantPlugins
  module BetterSmb
    class ActionPrepareValidIDs
      def initialize(app, env)
        @app = app
      end

      def call(env)
        env[:better_smb_valid_ids] = env[:machine].provider.driver.read_vms.values
        @app.call(env)
      end
    end
  end
end
