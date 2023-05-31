class Schedule < ApplicationRecord
  with_options presence: true do
    validates :event_name
    validates :started_at
    validates :finished_at
  end

  belongs_to :user
end
