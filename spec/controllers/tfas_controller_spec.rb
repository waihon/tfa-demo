require 'rails_helper'

describe TfasController do
  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do
    before do
      session[:user_id] = nil
    end

    it "cannot access show" do
      get :show, params: { user_id: @user }

      expect(response).to redirect_to(signin_url)
    end
  end

  context "when signed in as the wrong user" do
    before do
      @wrong_user = User.create!(user_attributes(name: "Wrong User",
                                                 username: "wronguser",
                                                 email: "wronguser@example.com"))
      session[:user_id] = @wrong_user.id
    end

    it "cannot access show" do
      get :show, params: { user_id: @user }

      expect(response).to redirect_to(root_url)
    end
  end
end
