class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :name   ,null: false
      t.string  :address
      t.date    :birthday
      t.string  :phone_number
      t.string  :phone_number_2
      t.date    :joining_day
      t.integer :working_days_id
      t.timestamps
    end
  end
end
