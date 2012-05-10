class ChangeColumnRateOfInvoice < ActiveRecord::Migration
  def up
  	change_column "invoices", "rate", :float, :default => 1
  end

  def down
  end
end
