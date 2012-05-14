class DropSomeUselessTables < ActiveRecord::Migration
  def up
  end

  def down
  	drop_table :banks
  	drop_table :invoice_statuses
  	drop_table :to_accountants
  	drop_table :invoices
  end
end
