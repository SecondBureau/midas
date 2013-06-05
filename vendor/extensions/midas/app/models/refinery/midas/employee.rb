module Refinery
  module Midas
    class Employee < Refinery::Core::BaseModel

      belongs_to :category, :class_name => "Refinery::Midas::Category", :foreign_key => :midas_category_id

      attr_accessible :foreigner, :service, :midas_category_id

      def title
        "#{category}"
      end
      
      def name
        "#{category.title}"
      end
    end
  end
end
