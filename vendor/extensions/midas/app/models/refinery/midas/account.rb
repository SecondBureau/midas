module Refinery
  module Midas
    class Account < Refinery::Core::BaseModel
      
      has_many :entries, :foreign_key => 'midas_account_id'

      attr_accessible :title, :description, :active, :currency, :confidential, :group, :opening_balance, :opened_on, :closed_on, :position

      translates :title, :description

      class Translation
        attr_accessible :locale
      end

      acts_as_indexed :fields => [:title, :description, :currency, :group]

      validates :title, :presence => true, :uniqueness => true
      
      validates :currency, :presence => true
      validates_inclusion_of :currency, :in => Refinery::Midas.config.devises, :message => "currency %s is not allowed."
      
    end
  end
end
