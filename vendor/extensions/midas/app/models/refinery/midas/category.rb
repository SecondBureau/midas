module Refinery
  module Midas
    class Category < Refinery::Core::BaseModel
      
      has_many :entries, :foreign_key => 'midas_category_id'

      attr_accessible :title, :description, :position

      translates :title, :description

      class Translation
        attr_accessible :locale
      end

      acts_as_indexed :fields => [:title, :description]

      validates :title, :presence => true, :uniqueness => true
    end
  end
end
