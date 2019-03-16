require 'rails_helper'

describe "Viewing the list of users" do
  it "shows the users" do
    user1 = User.create!(user_attributes(name: "Larry",
                                         email: "larry@example.com"))
    user2 = User.create!(user_attributes(name: "Moe",
                                         email: "moe@example.com"))
    user3 = User.create!(user_attributes(name: "Curly",
                                         email: "curly@example.com"))

    visit users_url

    (1..3).each do |i|
      user = eval("user#{i}")
      expect(page).to have_link(user.name)
    end
  end
end
