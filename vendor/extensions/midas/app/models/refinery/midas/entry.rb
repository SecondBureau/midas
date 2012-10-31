module Refinery
  module Midas
    class Entry < Refinery::Core::BaseModel
      
      belongs_to :account, :foreign_key => 'midas_account_id'
      belongs_to :category, :foreign_key => 'midas_category_id'

      attr_accessible :midas_category_id, :midas_account_id, :currency, :src_amount_in_cents, :amount_in_cents, :status, :title, :invoice, :cheque, :acountant_status, :valid_after, :position

      acts_as_indexed :fields => [:currency, :status, :acountant_status]

      validates :currency, :presence => true
      validates :src_amount_in_cents, :presence => true
      validates :title, :presence => true, :uniqueness => true

    end
  end
end
