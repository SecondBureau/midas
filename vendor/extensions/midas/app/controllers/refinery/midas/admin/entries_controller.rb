module Refinery
  module Midas
    module Admin
      class EntriesController < ::Refinery::AdminController
        
        after_filter :add_flash_message, :only => :destroy
        
        crudify :'refinery/midas/entry', :xhr_paging => true, :order => "valid_after DESC", :sortable => false
        
        def add_flash_message
          flash[:error] = @entry.errors.messages.values.join('<br/>') if @entry.errors.messages.any?
        end

      end
    end
  end
end
