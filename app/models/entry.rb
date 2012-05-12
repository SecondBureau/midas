class Entry < ActiveRecord::Base
  
  attr_accessible :label, :category_id, :account_id, :src_amount_in_cents,  :cheque_num, :invoice_num, :operation_date, :status
  
  belongs_to :account, :inverse_of => :entries
  
  
  before_validation :set_currency, :set_amount
  
  def amount
    amount_in_cents / 100.0
  end
  
  private
  
  def set_currency
    self.currency = self.account.currency if self.account
  end
  
  def set_amount
    if currency.eql?(Account::SYSTEM_CURRENCY)
      self.amount_in_cents = src_amount_in_cents
    else
      exchange_date = operation_date.end_of_month.future? ? Time.now : operation_date.end_of_month
      puts exchange_date
      begin
        self.amount_in_cents = src_amount_in_cents.send(currency.to_sym).send("to_#{Account::SYSTEM_CURRENCY}".to_sym, :at => exchange_date).to_f.round(0)
      rescue
        puts "Failure"
      end
    end
  end
  
end
