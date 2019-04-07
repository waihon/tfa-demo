require 'rails_helper'

describe "Viewing a user's profile page" do
  before(:each) do
    @user = User.create!(user_attributes)
  end

  it "shows the user's details" do
    sign_in(@user)

    visit user_url(@user)

    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.username)
    expect(page).to have_text(@user.email)
    expect(page).to have_text(@user.created_at.strftime("%B %Y"))
    expect(page.find('#profile-image')['src']).to eq("https://secure.gravatar.com/avatar/#{@user.gravatar_id}")
    expect(page.find('#profile-image')['alt']).to eq(@user.name)
  end

  context "TFA enabled" do
    before(:each) do
      @user.update_attribute(:tfa_enabled, true)
    end

    it "doesn't show Enable Two-Factor Authentication" do
      sign_in(@user)

      visit user_path(@user)

      expect(page).not_to have_link("Enable Two-Factor Authentication")
    end
  end

  context "TFA not enabled" do
    before(:each) do
      @user.update_attribute(:tfa_enabled, false)
    end

    it "shows Enable Two-Factor Authentication" do
      sign_in(@user)

      visit user_path(@user)

      expect(page).to have_link("Enable Two-Factor Authentication")
    end
  end
end
