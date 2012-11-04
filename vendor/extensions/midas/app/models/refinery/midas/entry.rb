module Refinery
  module Midas
    class Entry < Refinery::Core::BaseModel
      
      belongs_to :account, :foreign_key => 'midas_account_id'
      belongs_to :category, :foreign_key => 'midas_category_id'

      attr_accessible :account, :category, :midas_category_id, :midas_account_id, :currency, :src_amount_in_cents, :amount_in_cents, :status, :title, :invoice, :cheque, :acountant_status, :valid_after, :position

      acts_as_indexed :fields => [:currency, :status, :acountant_status]

      validates_presence_of :src_amount_in_cents, :title, :currency, :account, :category, :valid_after
      validates_inclusion_of :currency, :in => Refinery::Midas.config.devises, :message => "currency %s is not allowed."
      
      before_save :update_amount_in_cents
      
      after_save :update_account_balance
      
      def amount
        amount_in_cents / 100.0
      end
      
      def amount=(value)
        src_amount_in_cents = value * 100
      end
      
      
      private
      
      def update_account_balance
        account.update_current_balance
      end
      
      def update_amount_in_cents
        self.amount_in_cents = src_amount_in_cents
      end

    end
  end
end
