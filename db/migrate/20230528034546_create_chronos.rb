class CreateChronos < ActiveRecord::Migration[6.0]
  def change
    create_table :chronos do |t|
      t.string :name, null: false
      t.string :sleep_hours, null: false
      t.string :bed_time, null: false
      t.string :wake_up, null: false
      t.string :peak_time, null: false
      t.string :exercise, null: false
      t.timestamps
    end
  end
end
