class Invoice < ActiveRecord::Base
  belongs_to :category
  belongs_to :payment_mode
  belongs_to :invoice_status
  belongs_to :to_accountant
  belongs_to :bank
  attr_accessible :amount, :cheque_number, :date, :description, :invoice_number, :category_id, :payment_mode_id, :invoice_status_id, :to_accountant_id, :bank_id

end
