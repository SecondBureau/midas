module Refinery
  module Midas
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Midas

      engine_name :refinery_midas

      initializer "register refinerycms_employees plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "employees"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.midas_admin_employees_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/midas/employee',
            :title => 'title'
          }
          plugin.menu_match = %r{refinery/midas/employees(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Employees)
      end
    end
  end
end
