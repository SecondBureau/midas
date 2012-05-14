class DropTablePaymentModes < ActiveRecord::Migration
  def up
  end

  def down
  	drop_table :payment_modes
  end
end
