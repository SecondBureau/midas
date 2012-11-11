module Refinery
  module Midas
    class Account < Refinery::Core::BaseModel
      
      has_many :entries, :foreign_key => 'midas_account_id'

      attr_accessible :title, :description, :active, :currency, :confidential, :group, :opening_balance_in_cents, :opened_on, :closed_on, :position
      
      
      attr_accessor :reconciliated_entries, :reconciliation_code

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
      
      def reconciliated(date=nil)
        if date.nil?
          reconciliated_in_cents / 100.0
        else
          (opening_balance_in_cents + entries.reconciliated.where('valid_after <= ?', date).sum(:amount_in_cents)) / 100.0
        end
      end
      
      def reconciliate(entry_ids=nil, code=nil)
        entries.where(:id => entry_ids).each do |entry|
          entry.update_attributes(:reconciliation_code => code)
        end
        self.reconciliated_on = entries.reconciliated.maximum(:valid_after)
        self.reconciliated_at = Time.now
        self.reconciliated_in_cents = opening_balance_in_cents + entries.reconciliated.sum(:amount_in_cents)
      end
      
      def update_current_balance
        self.balance_in_cents = opening_balance_in_cents + entries.sum(:amount_in_cents)
        self.last_entry = entries.maximum(:valid_after)
        self.save
      end
      
    end
  end
end
