class AddTfaRecoveryCodesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tfa_recovery_codes, :string
  end
end
