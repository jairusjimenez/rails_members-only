class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create]

	def index
		@posts = Post.paginate(page: params[:page])
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.create(post_params)
		@post.user_id = current_user.id
		if @post.save
			flash[:success] = "Secret was successfully posted."
			redirect_to posts_path
		else
			render 'new'
		end
	end

	private

		def post_params
			params.require(:post).permit(:user_id, :title, :message)
		end

		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please login first."
				redirect_to login_url
			end
		end

end