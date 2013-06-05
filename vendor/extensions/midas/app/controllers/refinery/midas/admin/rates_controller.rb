module Refinery
  module Midas
    module Admin
      class RatesController < ::Refinery::AdminController
        
        crudify :'refinery/midas/rate', :xhr_paging => true
        
      end
    end
  end
end
