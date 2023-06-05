class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :event_name, null: false
      t.time :started_at, null: false
      t.time :finished_at, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
