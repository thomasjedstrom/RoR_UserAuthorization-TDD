class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	
	def show
		@user = User.find(params[:id])
	end

	def new
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			redirect_to '/users/' + user.id.to_s
		else
			flash[:reg_errors] = user.errors.full_messages
			redirect_to '/users/new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
    	@user = User.find(params[:id])
    	if @user.update_attribute(:name, params[:user][:name]) && @user.update_attribute(:email, params[:user][:email])
      		redirect_to '/users/'  + @user.id.to_s
    	else
			redirect_to '/users/' + @user.id.to_s + '/edit'
		end
	end

	def destroy
		@user = User.find(params[:id]).destroy
		session[:user_id] = nil
		redirect_to '/sessions/new'
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
