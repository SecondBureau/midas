module Refinery
  module Midas
    module Admin
      class EntriesController < ::Refinery::AdminController
        
        crudify :'refinery/midas/entry', :xhr_paging => true, :order => "valid_after DESC", :sortable => false

      end
    end
  end
end
