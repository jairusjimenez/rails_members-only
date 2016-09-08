module SessionsHelper

	def log_in(user)
		remember_token = User.new_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, remember_token)
		@current_user = user

	end

	def current_user
		@current_user ||= User.find_by(remember_token: cookies[:remember_token])
	end

	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out(user)
		current_user.update_attribute(:remember_token, User.new_token)
		cookies.delete :remember_token
		@current_user = nil
	end

	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

end