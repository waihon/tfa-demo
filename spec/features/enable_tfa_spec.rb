require "rails_helper"

describe "Enabling TFA" do
  before(:each) do
    @user = User.create!(user_attributes)
    @user.update_attribute(:tfa_enabled, false)
  end

  it "enable TFA for the user if verification code is valid" do
    sign_in(@user)

    expect(current_path).to eq(user_path(@user))

    click_on "Enable Two Factor Authentication"

    expect(current_path).to eq(new_user_tfa_path(@user))

    expect(page).to have_text("STEP 1: Get the App")
    expect(page).to have_text("Google Authenticator")

    expect(page).to have_text("STEP 2: Scan the Barcode")
    expect(page).to have_css("div#qrcode")
    expect(page).to have_text(@user.email)
    expect(page).to have_text(@user.otp_secret_key)

    expect(page).to have_text("STEP 3: Enter Verification Code")
    valid_verification_code = @user.otp_code
    fill_in "Verification Code", with: valid_verification_code

    click_on "Verify Code and Enable"

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_text("Two Factor Authentication has been successfully enabled!")
  end

  it "does not enable TFA for the user if verification code is invalid" do
    sign_in(@user)

    expect(current_path).to eq(user_path(@user))

    click_on "Enable Two Factor Authentication"

    expect(current_path).to eq(new_user_tfa_path(@user))

    invalid_verification_code = @user.otp_code.reverse
    fill_in "Verification Code", with: invalid_verification_code

    click_on "Verify Code and Enable"

    expect(current_path).to eq(user_tfa_path(@user))
    expect(page).to have_text("Invalid verification code!")
  end
end
