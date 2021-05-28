class CreateVacations < ActiveRecord::Migration[6.0]
  def change
    create_table :vacations do |t|
      t.float      :day ,null: false
      t.date       :paid_vacation_day ,null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
