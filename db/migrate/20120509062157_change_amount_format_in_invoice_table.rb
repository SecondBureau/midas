class ChangeAmountFormatInInvoiceTable < ActiveRecord::Migration
  def up
  	change_column :invoices, :amount, :decimal
  end

  def down
  	change_column :invoices, :amount, :float
  end
end
