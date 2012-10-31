module Refinery
  module Midas
    module Admin
      class EntriesController < ::Refinery::AdminController
        

        crudify :'refinery/midas/entry',
                :title_attribute => 'title', :xhr_paging => true

      end
    end
  end
end
