class Professional < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :email, presence: true
  validates :cell_phone, presence: true
end
