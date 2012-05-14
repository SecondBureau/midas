class Account < ActiveRecord::Base

  attr_accessible :label, :group, :currency, :fyeo,  :opened_at, :closed_at
  
  SYSTEM_CURRENCY = 'cny'
  
  #attr_accessible :closed_at, :currency, :label, :opened_at
  
  has_many :entries, :inverse_of => :account

end
