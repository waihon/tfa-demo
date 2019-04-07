class User < ApplicationRecord
  has_secure_password
  has_one_time_password

  serialize :tfa_recovery_codes, Array

  validates :name, presence: true
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                       format: /\A[a-zA-Z0-9]+\z/,
                       uniqueness: { case_sensitive: false }

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
    user && user.authenticate(password)
  end

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end

  def update_otp_secret_key
    update_otp_secret_key! if otp_secret_key.blank?
  end

  def update_otp_secret_key!
    self.otp_secret_key = ROTP::Base32.random_base32
    save!
  end

  def prepare_tfa
    update_otp_secret_key
  end

  def enable_tfa
    self.tfa_recovery_codes = generate_recovery_codes
    self.tfa_enabled = true
    save!
  end

  def reset_tfa
    self.otp_secret_key = nil
    self.tfa_enabled = false
    self.tfa_recovery_codes = nil
    save!
  end

  def authenticate_recovery(recovery_code)
    remaining_recovery_codes = tfa_recovery_codes.reject { |code| code == recovery_code }
    return false if remaining_recovery_codes.length == tfa_recovery_codes.length

    self.tfa_recovery_codes = remaining_recovery_codes
    save!

    return true
  end

  private

  def generate_recovery_codes
    recovery_codes = 16.times.map do
      2.times.map { SecureRandom.hex(3) }.join('-')
    end
  end
end
