module Refinery
  module Midas
    class Category < Refinery::Core::BaseModel
      
      has_many :entries, :foreign_key => 'midas_category_id'
      has_many :children, :class_name => "Refinery::Midas::Category", :foreign_key => "parent_id"
      belongs_to :parent, :class_name => "Refinery::Midas::Category"

      attr_accessible :code, :title, :description, :position, :parent_id

      translates :title, :description

      class Translation
        attr_accessible :locale
      end

      acts_as_indexed :fields => [:code, :title, :description]

      validates :code, :presence => true, :uniqueness => true
      
      scope :subcategories, where('parent_id is not null')
      
    end
  end
end
