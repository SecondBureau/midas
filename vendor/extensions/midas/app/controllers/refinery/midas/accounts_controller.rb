module Refinery
  module Midas
    class AccountsController < ::ApplicationController

      before_filter :find_all_accounts
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @account in the line below:
        present(@page)
      end

      def show
        @account = Account.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @account in the line below:
        present(@page)
      end

    protected

      def find_all_accounts
        @accounts = Account.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/accounts").first
      end

    end
  end
end
