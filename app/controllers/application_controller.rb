class ApplicationController < ActionController::Base
	layout "application"
	protect_from_forgery

	def authenticate
		
		if(auth)
			session[:auth], session[:username] = true, username
			return true
		end
		return false
	end
	
	def login
		:login
	end
	
	def trylogin
		auth = User.auth?(params[:email], params[:password])
		if(auth)
			session[:user_email] = params[:email]
			session[:auth] = true
			flash[:notice] = "Welcome!"
			redirect_to '/'
		else
			flash[:error] = "Email or password incorrect"
			redirect_to '/login'
		end
	end

	def logout
		reset_session
		flash[:message] = "Bye."
		redirect_to '/'
	end
end
