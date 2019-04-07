require "rails_helper"

describe "Authenticating Recovery Code" do
  before(:each) do
    @user = User.create!(user_attributes)
    @user.enable_tfa
  end

  it "prompts for a recovery code" do
    sign_in(@user)
    click_on "Enter a two-factor recovery code"

    expect(current_path).to eq(new_user_tfa_recovery_path(@user))
    expect(page).to have_field("Recovery Code")
  end

  it "sign in the user if the recovery code is valid" do
    sign_in(@user)
    click_on "Enter a two-factor recovery code"

    valid_recovery_code = @user.tfa_recovery_codes.last
    fill_in "Recovery Code", with: valid_recovery_code
    click_on "Verify Code"

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_text("Welcome back, #{@user.name}!")
  end

  it "doesn't sign in the user if the recovery code is invalid" do
    sign_in(@user)
    click_on "Enter a two-factor recovery code"

    invalid_recovery_code = @user.tfa_recovery_codes.last.reverse
    fill_in "Recovery Code", with: invalid_recovery_code
    click_on "Verify Code"

    expect(current_path).to eq(user_tfa_recovery_path(@user))
    expect(page).to have_text("Invalid recovery code!")
  end
end
