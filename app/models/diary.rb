class Diary < ApplicationRecord
  with_options presence: true do
    validates :date
    validates :liked
    validates :disliked
    validates :target
  end

  belongs_to :user
end
