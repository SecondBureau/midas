module Refinery
  module Midas
    module Admin
      class EntriesController < ::Refinery::AdminController
        
        after_filter :add_flash_message, :only => :destroy
        
        crudify :'refinery/midas/entry', :xhr_paging => true, :order => "valid_after DESC", :sortable => false
        
        def add_flash_message
          flash[:error] = @entry.errors.messages.values.join('<br/>') if @entry.errors.messages.any?
        end

        def reconciliate
          Entry.update_all({reconciliated_at: DateTime.now, reconciliation_code: params[:reconciliation_code]}, {id: params[:entry_ids]})
          redirect_to refinery.midas_admin_accounts_url
        end
      end
    end
  end
end
