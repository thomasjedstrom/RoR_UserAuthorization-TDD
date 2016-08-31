require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @secret = @user.secrets.create(content: 'Oops')
    @like = Like.create(user: @user, secret: @secret)
  end
  describe "when not logged in" do
  	it "does not allow you to like" do
      post :create
  		expect(response).to redirect_to("/sessions/new")
  	end
  	it "does not allow you to unlike" do
  		delete :destroy, id: @like
      expect(response).to redirect_to("/sessions/new")
  	end
  end
  describe "when signed in as the wrong user" do
    before do
      @wrong_user = User.create(name:'john', email: 'john@john.com', password: 'password', password_confirmation: 'password')
      session[:user_id] = @wrong_user.id
    end
    it "doesn't allow you to cause another user to like a secret" do
      # post :create, secret_id: @secret.id
      # expect(page).to have_text('1 likes')
      # click_button 'Log Out'
      # session[:user_id] = @user.id
      # visit "/secrets"
      # expect(response).to redirect_to("/sessions/new")
    end
    it "doesn't allow you to cause another user to unlike a secret" do
      # session[:user_id] = @user.id
      # delete :destroy, id: @like, user_id: @user.id
      # expect(response).to redirect_to("/sessions/new")
    end
  end 
end