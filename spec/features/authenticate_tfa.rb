require "rails_helper"

describe "Authenticating TFA" do
  before(:each) do
    @user = User.create!(user_attributes)
    @user.enable_tfa
  end

  it "prompts for a verification code" do
    sign_in(@user)

    expect(current_path).to eq(new_user_tfa_session_path(@user))

    expect(page).to have_field("Verification Code")
  end

  it "sign in the user if the verification code is valid" do
    sign_in(@user)

    valid_verification_code = @user.otp_code
    fill_in "Verification Code", with: valid_verification_code
    click_on "Verify Code"

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_text("Welcome back, #{@user.name}!")
  end

  it "doesn't sign in the user if the verification code is valid" do
    sign_in(@user)

    invalid_verification_code = @user.otp_code.reverse
    fill_in "Verification Code", with: invalid_verification_code
    click_on "Verify Code"

    expect(current_path).to eq(user_tfa_session_path(@user))
    expect(page).to have_text("Invalid verification code!")
  end
end
