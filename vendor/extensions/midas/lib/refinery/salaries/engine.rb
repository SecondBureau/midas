module Refinery
  module Midas
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Midas

      engine_name :refinery_midas

      initializer "register refinerycms_salaries plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "salaries"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.midas_admin_salaries_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/midas/salary',
            :title => 'title'
          }
          plugin.menu_match = %r{refinery/midas/salaries(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Salaries)
      end
    end
  end
end
