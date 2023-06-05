class Schedule < ApplicationRecord
  with_options presence: true do
    validates :event_name
    validates :started_at
    validates :finished_at
  end

  
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :week_id, numericality: { other_than: 1, message: "平日もしくは休日を選択してください" }
  
  belongs_to :week
  belongs_to :user
end
