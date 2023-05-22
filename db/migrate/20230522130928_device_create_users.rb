class DeviceCreateUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.integer :chrono_type_id
    end
  end
end
