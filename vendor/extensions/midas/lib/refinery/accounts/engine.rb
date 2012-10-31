module Refinery
  module Midas
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Midas

      engine_name :refinery_midas

      initializer "register refinerycms_accounts plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "accounts"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.midas_admin_accounts_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/midas/account'
          }
          plugin.menu_match = %r{refinery/midas/accounts(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Accounts)
      end
    end
  end
end
