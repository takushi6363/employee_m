class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.integer    :price
      t.date       :purchase_date
      t.integer    :user_id
      t.timestamps
    end
  end
end
