class Professional < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: false
  validates :email, presence: true
  validates :cell_phone, presence: false
end
