class CreateMidasEntries < ActiveRecord::Migration

  def up
    create_table :refinery_midas_entries do |t|
      t.integer :midas_category_id
      t.integer :midas_account_id
      t.string :currency
      t.integer :src_amount_in_cents
      t.integer :amount_in_cents
      t.string :status
      t.string :title
      t.string :invoice
      t.string :cheque
      t.string :acountant_status
      t.date :valid_after
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-midas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/midas/entries"})
    end

    drop_table :refinery_midas_entries

  end

end
