class ChronoType < ActiveHash::Base
  self.data = [
    { id: 1, name: 'ライオン', sleep_hours: '7〜8', go_to_bed: '22:00', wake_up: '6:00', peak: '午前中', execise: '17:00〜18:00'},
    { id: 2, name: 'クマ', sleep_hours: '7〜8', go_to_bed: '23:00', wake_up: '7:00', peak: '10:00〜14:00', execise: '18:00〜19:00'},
    { id: 3, name: 'オオカミ', sleep_hours: '7〜8', go_to_bed: '24:00', wake_up: '7:30', peak: '17:00〜24:00', execise: '18:00〜20:00'},
    { id: 4, name: 'イルカ', sleep_hours: '6〜7', go_to_bed: '24:00', wake_up: '6:30', peak: ['10:00〜12:00', '13:00〜14:00'], execise: '7:00〜9:00'}
  ]

  include ActiveHash::Associations
  has_many :users
end