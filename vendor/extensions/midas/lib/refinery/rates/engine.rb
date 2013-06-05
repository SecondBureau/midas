module Refinery
  module Midas
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Midas

      engine_name :refinery_midas

      initializer "register refinerycms_rates plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "rates"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.midas_admin_rates_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/midas/rate',
            :title => 'title'
          }
          plugin.menu_match = %r{refinery/midas/rates(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Rates)
      end
    end
  end
end
