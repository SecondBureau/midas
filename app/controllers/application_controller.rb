class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :redirect_to_login
  
  protected
    def redirect_to_login
      if !refinery_user?
        if (params[:controller] != "refinery/sessions" && params[:action] != "new")
          redirect_to '/refinery/login'
        end
      end
    end
end
