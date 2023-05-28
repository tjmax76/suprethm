class AddColumnToChronos < ActiveRecord::Migration[6.0]
  def change
    add_column :chronos, :content, :text
  end
end
