class Account < ActiveRecord::Base
  
  SYSTEM_CURRENCY = 'cny'
  
  #attr_accessible :closed_at, :currency, :label, :opened_at
  
  has_many :entries, :inverse_of => :account

end
