class Rental < ApplicationRecord
  enum status: { scheduled: 0, ongoing: 2, finalized: 3 }
  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary
  belongs_to :rental_price
end
