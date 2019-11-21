class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :car
end
