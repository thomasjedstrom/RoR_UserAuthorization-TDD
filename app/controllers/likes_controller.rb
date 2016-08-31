class LikesController < ApplicationController
	before_action :require_login, only: [:create, :destroy]
	# before_action :require_correct_user, only: [:create, :destroy]

	def create
		secret = Secret.find(params[:secret_id])
		Like.create(user: current_user, secret: secret)
		redirect_to "/secrets"
	end
	def destroy
		secret = Secret.find(params[:id])
		current_user.secrets_liked.destroy(secret.id)
	    redirect_to "/secrets"
	end
end
