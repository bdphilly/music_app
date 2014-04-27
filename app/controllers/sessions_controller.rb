class SessionsController < ApplicationController
  before_action :require_signed_in!, :only => [:show]
  before_action :require_signed_out!, :only => [:create, :new]	

	def create
		@user = User.find_by_credentials(params[:user][:email], params[:user][:password])
		if @user
			sign_in(@user)
			redirect_to bands_url
		else
			flash.now[:errors] = ["Invalid username/password"]
		end
	end

	def destroy
		sign_out
		redirect_to new_session_url
	end

	def new
	end

	private
	def user_params
		params.require(:user).permit(:email, :passoword)
	end

end
