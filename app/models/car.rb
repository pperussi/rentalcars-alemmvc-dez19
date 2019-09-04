class Car < ApplicationRecord
  belongs_to :car_model

  validates :car_km, presence: true
  validates :color, presence: true
  validates :license_plate, presence: true
end
