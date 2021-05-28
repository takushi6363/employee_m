class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.integer    :price ,null: false
      t.date       :purchase_date ,null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
