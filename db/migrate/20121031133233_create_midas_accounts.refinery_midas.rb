# This migration comes from refinery_midas (originally 1)
class CreateMidasAccounts < ActiveRecord::Migration

  def up
    create_table :refinery_midas_accounts do |t|
      t.string :title
      t.string :number
      t.text :description
      t.boolean :active
      t.string :currency
      t.boolean :confidential
      t.string :group
      t.integer :opening_balance_in_cents, :default => 0
      t.date :opened_on
      t.date :closed_on
      t.integer :position
      t.date :last_entry
      t.integer :balance_in_cents, :default => 0

      t.timestamps
    end

    Refinery::Midas::Account.create_translation_table! :title => :string, :description => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-midas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/midas/accounts"})
    end

    drop_table :refinery_midas_accounts

    Refinery::Midas::Account.drop_translation_table!

  end

end
