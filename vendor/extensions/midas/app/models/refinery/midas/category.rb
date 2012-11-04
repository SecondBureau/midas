module Refinery
  module Midas
    class Category < Refinery::Core::BaseModel
      
      has_many :entries, :foreign_key => 'midas_category_id'

      attr_accessible :code, :title, :description, :position

      translates :title, :description

      class Translation
        attr_accessible :locale
      end

      acts_as_indexed :fields => [:code, :title, :description]

      validates :code, :presence => true, :uniqueness => true
    end
  end
end
