class CreateInvoiceStatuses < ActiveRecord::Migration
  def change
    create_table :invoice_statuses do |t|
      t.string :label

      t.timestamps
    end
  end
end
