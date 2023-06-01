class AddColumnToSchedule < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :week_id, :integer
  end
end
