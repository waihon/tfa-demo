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
    update_attribute(:otp_secret_key, ROTP::Base32.random_base32)
  end

  def generate_recovery_codes
    generate_recovery_codes! if tfa_recovery_codes.blank?
  end

  def prepare_tfa
    update_otp_secret_key
  end

  def enable_tfa
    generate_recovery_codes
    update_attribute(:tfa_enabled, true)
  end

  def reset_tfa
    update_attributes(otp_secret_key: nil, tfa_enabled: false, tfa_recovery_codes: nil)
  end

  private

  def generate_recovery_codes!
    digits = 6
    recovery_codes = 16.times.map do
      2.times.map { SecureRandom.hex(3) }.join('-')
    end
    update_attribute(:tfa_recovery_codes, recovery_codes)
  end
end
