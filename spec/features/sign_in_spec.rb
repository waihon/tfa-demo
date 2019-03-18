require "rails_helper"

describe "Signing in", js: true do
  it "prompts for an email and password" do
    # Capybara somehow couldn't recognize any link with Bootstrap navbar-collapse
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
end
