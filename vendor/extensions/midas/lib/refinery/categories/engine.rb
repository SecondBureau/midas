module Refinery
  module Midas
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Midas

      engine_name :refinery_midas

      initializer "register refinerycms_categories plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "categories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.midas_admin_categories_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/midas/category'
          }
          plugin.menu_match = %r{refinery/midas/categories(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Categories)
      end
    end
  end
end
