class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :date
      t.references :category
      t.references :payment_mode
      t.string :description
      t.float :amount
      t.references :invoice_status
      t.string :cheque_number
      t.string :invoice_number
      t.references :to_accountant
      t.references :bank

      t.timestamps
    end
    add_index :invoices, :category_id
    add_index :invoices, :payment_mode_id
    add_index :invoices, :invoice_status_id
    add_index :invoices, :to_accountant_id
    add_index :invoices, :bank_id
  end
end
