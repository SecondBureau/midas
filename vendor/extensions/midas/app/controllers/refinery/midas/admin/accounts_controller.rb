module Refinery
  module Midas
    module Admin
      class AccountsController < ::Refinery::AdminController
        
        before_filter :reconciliate_entries, :only => :update

        crudify :'refinery/midas/account', :xhr_paging => true
        
        def reconciliation
          @account = Refinery::Midas::Account.find(params[:account_id])
        end
        
        private 
        
        def reconciliate_entries
          unless (entries = params[:account][:reconciliated_entries]).nil?
            @account.reconciliate(entries, params[:account][:reconciliation_code])
          end
        end

      end
    end
  end
end
