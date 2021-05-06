class AddAttrEncryptedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :encrypted_my_number, :string
    add_column :users, :encrypted_my_number_iv, :string
  end
end
