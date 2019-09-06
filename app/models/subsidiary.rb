class Subsidiary < ApplicationRecord
  has_one :address
  has_many :rental_prices
  accepts_nested_attributes_for :address
  validates :name, presence: true
  validates :cnpj, presence: true
end
