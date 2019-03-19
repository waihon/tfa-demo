require "rails_helper"

describe "Signing in" do
  it "prompts for an email/username and password" do
    # Capybara somehow couldn't recognize any link within Bootstrap's navbar-collapse
    visit signin_path

    expect(current_path).to eq(signin_path)

    expect(page).to have_field("Email or Username")
    expect(page).to have_field("Password")
    expect(page).to have_button("Sign In")
    expect(page).to have_link("Sign up!")
  end

  it "stays on the same page when email/username is not entered", js: true do
    visit signin_path

    expect(current_path).to eq(signin_path)

    fill_in "Password", with: "secret"

    click_button "Sign In"

    expect(current_path).to eq(signin_path) # stays on the same page

    message = page.find("#email_or_username").native.attribute("validationMessage")
    expect(message).to eq "Please fill out this field."
  end

  it "stays on the same page when password is not entered", js: true do
    visit signin_path

    expect(current_path).to eq(signin_path)

    fill_in "Email or Username", with: "user@example.com"

    click_button "Sign In"

    expect(current_path).to eq(signin_path) # stays on the same page

    message = page.find("#password").native.attribute("validationMessage")
    expect(message).to eq "Please fill out this field."
  end

  it "signs in the user if the email/password combination is valid" do
    user = User.create!(user_attributes)

    visit signin_path

    fill_in "Email or Username", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_text("Welcome back, #{user.name}!")
  end

  it "signs in the user if the username/password combination is valid" do
    user = User.create!(user_attributes)

    visit signin_path

    fill_in "Email or Username", with: user.username
    fill_in "Password", with: user.password

    click_button "Sign In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_text("Welcome back, #{user.name}!")
  end

  it "does not sign in the user if the email is invalid" do
    user = User.create!(user_attributes)

    visit signin_path

    fill_in "Email or Username", with: "invalid" + user.email
    fill_in "Password", with: user.password

    click_button "Sign In"

    # HTML5 required validation has been passed so :new view is rendered
    expect(current_path).to eq(session_path)

    expect(page).to have_text("Invalid email/username/password combination!")
  end

  it "does not sign in the user if the username is invalid" do
    user = User.create!(user_attributes)

    visit signin_path

    fill_in "Email or Username", with: "invalid" + user.username
    fill_in "Password", with: user.password

    click_button "Sign In"

    # HTML5 required validation has been passed so :new view is rendered
    expect(current_path).to eq(session_path)

    expect(page).to have_text("Invalid email/username/password combination!")
  end

  it "does not sign in the user if the password is invalid" do
    user = User.create!(user_attributes)

    visit signin_path

    fill_in "Email or Username", with: user.email
    fill_in "Password", with: "invalid_#{user.password}"

    click_button "Sign In"

    # HTML5 required validation has been passed so :new view is rendered
    expect(current_path).to eq(session_path)

    expect(page).to have_text("Invalid email/username/password combination!")
  end
end
