module Refinery
  module Midas
    module Admin
      class AccountsController < ::Refinery::AdminController

        crudify :'refinery/midas/account', :xhr_paging => true

      end
    end
  end
end
