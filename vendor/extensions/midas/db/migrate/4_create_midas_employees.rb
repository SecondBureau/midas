class CreateMidasEmployees < ActiveRecord::Migration
  def up
    create_table :refinery_midas_employees do |t|
      
      t.boolean :foreigner
      t.boolean :service
      t.integer :midas_category_id

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-midas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/midas/employees"})
    end

    drop_table :refinery_midas_employees

  end
end
