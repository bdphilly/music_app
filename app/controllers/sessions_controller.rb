class SessionsController < ApplicationController
  before_action :require_signed_in!, :only => [:show]
  before_action :require_signed_out!, :only => [:create, :new]	

	def create
		@user = User.find_by_credentials(params[:user][:email], params[:user][:password])
		if @user
			sign_in(@user)
			redirect_to user_url(@user)
		else
			render :json => "Invalid Credentials you Fool!"
		end
	end

	def destroy
		sign_out
	end

	def new
	end

	private
	def user_params
		params.require(:user).permit(:email, :passoword)
	end

end
