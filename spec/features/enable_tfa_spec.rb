require "rails_helper"

describe "Enabling TFA" do
  before(:each) do
    @user = User.create!(user_attributes)
    @user.update_attribute(:tfa_enabled, false)
  end

  it "enable TFA for the user if authentication code is valid" do
    sign_in(@user)

    expect(current_path).to eq(user_path(@user))

    click_on "Enable Two-Factor Authentication"

    expect(current_path).to eq(new_user_tfa_path(@user))

    expect(page).to have_text("STEP 1: Get the App")
    expect(page).to have_text("Google Authenticator")

    expect(page).to have_text("STEP 2: Scan the Barcode")
    expect(page).to have_css("div#qrcode")
    expect(page).to have_text(@user.email)
    expect(page).to have_text(@user.otp_secret_key)

    expect(page).to have_text("STEP 3: Enter Authentication Code")
    valid_authentication_code = @user.otp_code
    fill_in "Authentication Code", with: valid_authentication_code

    click_on "Verify Code and Enable"

    expect(current_path).to eq(user_tfa_path(@user))
    expect(page).to have_text("Two-Factor Authentication has been successfully enabled!")
    expect(page).to have_text("Two-Factor Recovery Codes")
    @user.tfa_recovery_codes.each do |code|
      expect(page).to have_text(code)
    end
  end

  it "does not enable TFA for the user if authentication code is invalid" do
    sign_in(@user)

    expect(current_path).to eq(user_path(@user))

    click_on "Enable Two-Factor Authentication"

    expect(current_path).to eq(new_user_tfa_path(@user))

    invalid_authentication_code = @user.otp_code.reverse
    fill_in "Authentication Code", with: invalid_authentication_code

    click_on "Verify Code and Enable"

    expect(current_path).to eq(user_tfa_path(@user))
    expect(page).to have_text("Invalid authentication code!")
  end
end
