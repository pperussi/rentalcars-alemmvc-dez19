class Car < ApplicationRecord
  belongs_to :car_model

  validates :car_km, presence: { message: 'Quilometragem não pode ficar '\
                                          'em branco' }
  validates :color, presence: { message: 'Cor não pode ficar em branco' }
  validates :license_plate, presence: { message: 'Placa não pode '\
                                                 'ficar em branco' }
end
