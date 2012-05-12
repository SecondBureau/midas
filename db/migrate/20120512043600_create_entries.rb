class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :label
      t.integer :category_id
      t.integer :account_id
      t.string :currency
      t.integer :src_amount_in_cents, :default => 0
      t.integer :amount_in_cents, :default => 0
      t.string :status
      t.string :invoice_num
      t.string :cheque_num
      t.string :accountant_status
      t.datetime :operation_date

      t.timestamps
    end
  end
end
