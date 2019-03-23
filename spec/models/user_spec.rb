require 'rails_helper'

describe "Authenticate" do
  before(:each) do
    @user = User.create!(user_attributes)
  end

  it "returns the user if the email and password match" do
    expect(User.authenticate(@user.email, @user.password)).to eq(@user)
  end

  it "return non-true value if the email does not match" do
    expect(User.authenticate("nomatch", @user.password)).not_to eq(true)
  end

  it "return non-true value if the password does not match" do
    expect(User.authenticate(@user.email, "nomatch")).not_to eq(true)
  end
end
