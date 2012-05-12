class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :label
      t.string :group, :default => "cash"
      t.string :currency, :default => "cny"
      t.boolean :fyeo, :default => false
      t.datetime :opened_at
      t.datetime :closed_at
      t.timestamps
    end
    
    add_index :accounts, :label, :unique => true
    
  end
  
end
