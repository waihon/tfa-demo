require 'rails_helper'

describe "Viewing a user's profile page" do
  it "shows the user's details" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_url(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.username)
    expect(page).to have_text(user.email)
    expect(page).to have_text(user.created_at.strftime("%B %Y"))
    expect(page.find('#profile-image')['src']).to eq("https://secure.gravatar.com/avatar/#{user.gravatar_id}")
    expect(page.find('#profile-image')['alt']).to eq(user.name)
  end
end
