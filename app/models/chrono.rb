class Chrono < ApplicationRecord

  has_one_attached :image
  has_many :users
end
