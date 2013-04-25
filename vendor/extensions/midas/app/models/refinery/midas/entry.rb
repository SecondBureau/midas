module Refinery
  module Midas
    class Entry < Refinery::Core::BaseModel
      
      belongs_to :account, :foreign_key => 'midas_account_id'
      belongs_to :category, :foreign_key => 'midas_category_id'

      attr_accessible :src_amount, :account, :category, :midas_category_id, :midas_account_id, :currency, :src_amount_in_cents, :amount_in_cents, :status, :title, :invoice, :cheque, :acountant_status, :valid_after, :position, :reconciliation_code, :reconciliated_at

      delegate :title, :to => :account, :prefix => true


      acts_as_indexed :fields => [:title, :account_title]

      validates_presence_of :title, :currency, :account, :category, :valid_after
      validates_inclusion_of :currency, :in => Refinery::Midas.config.devises, :message => "currency %s is not allowed."

      before_validation :set_currency
      before_save :update_amount_in_cents
      before_save :update_reconciliated_at, :if => :reconciliation_code_changed?
      
      before_destroy :protect_reconcilated, :unless => "reconciliation_code.nil?"
      
      after_save :update_account_balance
      
      scope :reconciliated, where('reconciliation_code is not null')
      

      def src_amount
        BigDecimal(src_amount_in_cents.to_s) / 100 if src_amount_in_cents?
      end
      
      def src_amount=(value)
        self.src_amount_in_cents = value.to_d * 100 if value.present?
      end
      
      
      def amount
        amount_in_cents / 100.0
      end
      
      def amount=(value)
        src_amount_in_cents = value * 100
      end
      
      def set_currency
      	self.currency = self.account.currency
      end
      
      
      private


      def update_account_balance
        account.update_current_balance
      end
      
      def update_amount_in_cents
        self.amount_in_cents = src_amount_in_cents.in(currency.to_sym).to(:cny)
      end
      
      def update_reconciliated_at
        reconciliated_at = Time.now
      end
      
      def protect_reconcilated
        errors[:base] << "reconcilated record, can not be destroy"
        false
      end

    end
  end
end
