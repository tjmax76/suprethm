class Week < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '平日' },
    { id: 3, name: '休日' }
  ]

  include ActiveHash::Associations
  has_many :schedules
  
end
