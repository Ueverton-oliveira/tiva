class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.datetime :initial_date
      t.datetime :end_date
      t.time :initial_hour
      t.time :end_hour
      t.references :professional, null: false, foreign_key: true

      t.timestamps
    end
  end
end
