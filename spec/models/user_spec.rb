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

describe "One Time Password" do
  before(:each) do
    @user = User.create!(user_attributes)
  end

  context "with OTP secret key" do
    it "a new user has an OTP secret key populated by default" do
      expect(@user.otp_secret_key).not_to eq(nil)
    end

    it "generates OTP code" do
      expect(@user.otp_code).not_to eq(nil)
    end

    it "authenticate_otp returns true if the code provided is matched" do
      matched_otp_code = @user.otp_code
      expect(@user.authenticate_otp(matched_otp_code)).to be_truthy
    end

    it "authenticate_otp returns false if the code provided is unmatched" do
      unmatched_otp_code = (@user.otp_code.to_i - 1).to_s
      expect(@user.authenticate_otp(unmatched_otp_code)).to be_falsey
    end

    it "authenticate-otp returns false if the code provided is outdated" do
      outdated_otp_code = @user.otp_code
      sleep 30
      expect(@user.authenticate_otp(outdated_otp_code)).to be_falsey
    end
  end

  context "without OTP secret key" do
    before(:each) do
      @user.update_attribute(:otp_secret_key, nil)
    end

    it "OTP secret key is nil" do
      expect(@user.otp_secret_key).to eq(nil)
    end

    it "doesn't generate OTP code" do
      expect { @user.otp_code }.to raise_error(NoMethodError)
    end

  end
end

describe "Update OTP Secret Key" do
  before(:each) do
    @user = User.create!(user_attributes)
  end

  context "with OTP secret key" do
    it "won't update the secret key" do
      existing_secret_key = @user.otp_secret_key
      @user.update_otp_secret_key
      expect(@user.otp_secret_key).to eq(existing_secret_key)
    end

  end

  context "without OTP secret key" do
    before(:each) do
      @user.update_attribute(:otp_secret_key, nil)
    end

    it "will update the secret key" do
      existing_secret_key = @user.otp_secret_key
      expect(existing_secret_key).to be_nil
      @user.update_otp_secret_key
      expect(@user.otp_secret_key).not_to be_nil
    end
  end
end

describe "Force Update OTP Secret Key" do
  before(:each) do
    @user = User.create!(user_attributes)
  end

  context "with OTP secret key" do
    it "will update the secret key" do
      existing_secret_key = @user.otp_secret_key
      expect(existing_secret_key).not_to be_nil
      @user.update_otp_secret_key!
      expect(@user.otp_secret_key).not_to eq(existing_secret_key)
    end

  end

  context "without OTP secret key" do
    before(:each) do
      @user.update_attribute(:otp_secret_key, nil)
    end

    it "will update the secret key" do
      existing_secret_key = @user.otp_secret_key
      expect(existing_secret_key).to be_nil
      @user.update_otp_secret_key!
      expect(@user.otp_secret_key).not_to be_nil
    end
  end
end
