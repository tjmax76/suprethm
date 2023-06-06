class CreateDiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :diaries do |t|
      t.date :date, null: false
      t.string :liked, null: false
      t.string :disliked, null: false
      t.string :target, null: false
      t.references :user, null: false, foreigen_key: true
      t.timestamps
    end
  end
end
