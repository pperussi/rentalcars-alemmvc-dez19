class CarModel < ApplicationRecord
  belongs_to :manufacture

  validates :name, presence: true
  validates :year, presence: true
  validates :car_options, presence: true
end
