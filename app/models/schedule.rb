class Schedule < ApplicationRecord
  belongs_to :professional

  validates :initial_date, presence: true
  validates :end_date, presence: true
  validates :initial_hour, presence: true
  validates :end_hour, presence: true
end
