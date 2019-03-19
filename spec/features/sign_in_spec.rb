require "rails_helper"

describe "Signing in", js: true do
  it "prompts for an email and password" do
    # Capybara somehow couldn't recognize any link within Bootstrap's navbar-collapse
    visit signin_path

    expect(current_path).to eq(signin_path)

    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    expect(page).to have_button("Sign In")
    expect(page).to have_link("Sign up!")
  end

  it "stays on the same page when email or password is not entered" do
    visit signin_path

    expect(current_path).to eq(signin_path)

    fill_in "Email", with: "user@example.com"

    click_button "Sign In"

    expect(current_path).to eq(signin_path) # stays on the same page

    message = page.find("#password").native.attribute("validationMessage")
    expect(message).to eq "Please fill out this field."
  end

  it "signs in the user if the email/password combination is valid" do
    user = User.create!(user_attributes)

    visit signin_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_text("Welcome back, #{user.name}!")
  end

  it "does not sign in the user if the email/password combination is invalid" do
    user = User.create!(user_attributes)

    visit signin_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "invalid_#{user.password}"

    click_button "Sign In"

    # HTML5 required validation has been passed so :new view is rendered
    expect(current_path).to eq(session_path)

    expect(page).to have_text("Invalid email/password combination")
  end
end
