
class CreateMidasCategories < ActiveRecord::Migration

  def up
    create_table :refinery_midas_categories do |t|
      t.string :title
      t.text :description
      t.integer :position

      t.timestamps
    end

    Refinery::Midas::Category.create_translation_table! :title => :string, :description => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-midas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/midas/categories"})
    end

    drop_table :refinery_midas_categories

    Refinery::Midas::Category.drop_translation_table!

  end

end
