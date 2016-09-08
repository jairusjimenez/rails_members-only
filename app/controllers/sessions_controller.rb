class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in @user
			flash[:success] = "Successfully logged in!"
			redirect_back_or @user
		else
			flash.now[:danger] = "Invalid email/password"
			render 'new'
		end
	end

	def destroy
		log_out current_user
		flash[:info] = "Successfully looged out!"
		redirect_to root_url
	end

end