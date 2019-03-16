require 'rails_helper'

describe "Viewing the list of users" do
  it "shows the users" do
    user1 = User.create!(user_attributes(name: "Larry",
                                         username: "larryware",
                                         email: "larry@example.com"))
    user2 = User.create!(user_attributes(name: "Moe",
                                         username: "moekit",
                                         email: "moe@example.com"))
    user3 = User.create!(user_attributes(name: "Curly",
                                         username: "curlymod",
                                         email: "curly@example.com"))

    visit users_url

    (1..3).each do |i|
      user = eval("user#{i}")
      expect(page).to have_link(user.name)
      expect(page).to have_text(user.username)
      expect(page).to have_text(user.email)
    end
  end
end
