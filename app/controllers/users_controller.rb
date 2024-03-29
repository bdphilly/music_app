class UsersController < ApplicationController
  before_action :require_signed_in!, :only => [:show]
  before_action :require_signed_out!, :only => [:create, :new]	

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			sign_in(@user)
			redirect_to bands_url
		else
			flash.now[:errors] = @user.errors.full_messages
			render :new
		end
	end

	# def show
	# 	if params.include?(:id)
	# 		@user = User.find(params[:id])
	# 		redirect_to user_url(@user)
	# 	else
	# 		render :json => "uh oh"
	# 	end
	# end

	private
	def user_params
		params.require(:user).permit(:email, :password)
	end
	
end
