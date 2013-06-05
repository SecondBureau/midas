module Refinery
  module Midas
    module Admin
      class EmployeesController < ::Refinery::AdminController
        
        after_filter :add_flash_message, :only => :destroy
        
        before_filter :new, :only => :index
        
        crudify :'refinery/midas/employee', :xhr_paging => true, :order => "midas_category_id ASC", :sortable => false
        
        def add_flash_message
          flash[:error] = @entry.errors.messages.values.join('<br/>') if @entry.errors.messages.any?
        end
      end
    end
  end
end
