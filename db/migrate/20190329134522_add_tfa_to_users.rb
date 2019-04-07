class AddTfaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :otp_secret_key, :string
    add_column :users, :tfa_enabled, :boolean
  end
end
