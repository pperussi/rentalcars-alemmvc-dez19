class Category < ApplicationRecord
  validates :name, presence: true
  has_many :rental_prices
end
