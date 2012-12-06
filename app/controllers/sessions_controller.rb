class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination' 
			render 'new'
		end
	end

	def destory
		session[:user_id] = nil
		flash[:notice] = "You are now logged out"
		redirect_to root_url
	end
end
