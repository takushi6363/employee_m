class CreateVacations < ActiveRecord::Migration[6.0]
  def change
    create_table :vacations do |t|
      t.float      :day
      t.date       :paid_vacation_day
      t.integer    :user_id
      t.timestamps
    end
  end
end
