module Refinery
  module Midas
    class Account < Refinery::Core::BaseModel
      
      has_many :entries, :foreign_key => 'midas_account_id'

      attr_accessible :title, :description, :active, :currency, :confidential, :group, :opening_balance_in_cents, :opened_on, :closed_on, :position, :last_entry, :balance_in_cents

      translates :title, :description

      class Translation
        attr_accessible :locale
      end

      acts_as_indexed :fields => [:title, :description, :currency, :group]

      validates :title, :presence => true, :uniqueness => true
      
      validates :currency, :presence => true
      validates_inclusion_of :currency, :in => Refinery::Midas.config.devises, :message => "currency %s is not allowed."
      
      def balance(date=nil)
        if date.nil? 
          balance_in_cents / 100.0
        else
          (opening_balance_in_cents + entries.where('valid_after <= ?', date).sum(:amount_in_cents)) / 100.0
        end
      end
      
      def update_current_balance
        update_attributes(  :balance_in_cents => opening_balance_in_cents + entries.sum(:amount_in_cents),
                            :last_entry => entries.maximum(:valid_after) )
      end
      
    end
  end
end
