module Refinery
  module Midas
    class EntriesController < ::ApplicationController

      before_filter :find_all_entries
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @entry in the line below:
        present(@page)
      end

      def show
        @entry = Entry.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @entry in the line below:
        present(@page)
      end

    protected

      def find_all_entries
        @entries = Entry.order('valid_after ASC')
        if params['account_id']
          @entries = @entries.where(:midas_account_id => params['account_id'])
        end

      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/entries").first
      end

    end
  end
end
