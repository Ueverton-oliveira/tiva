class Professional < ApplicationRecord
  has_many :addresses
  has_many :schedules

  validates :name, presence: true
  validates :description, presence: false
  validates :email, presence: true
  validates :cell_phone, presence: false
end
