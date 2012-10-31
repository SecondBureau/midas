module Refinery
  module Midas
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Midas

      engine_name :refinery_midas

      initializer "register refinerycms_entries plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "entries"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.midas_admin_entries_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/midas/entry',
            :title => 'title'
          }
          plugin.menu_match = %r{refinery/midas/entries(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Entries)
      end
    end
  end
end
