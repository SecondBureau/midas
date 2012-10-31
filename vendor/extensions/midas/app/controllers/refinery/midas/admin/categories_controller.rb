module Refinery
  module Midas
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/midas/category', :xhr_paging => true

      end
    end
  end
end
