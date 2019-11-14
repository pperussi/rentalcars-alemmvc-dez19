class Rental < ApplicationRecord
  enum status: { scheduled: 0, ongoing: 2, finalized: 3 }
  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary
  validates :start_date, :end_date, :price_projection, presence: true

  def calculate_price_projection
    return 0 unless self.start_date && self.end_date && self.category
    days = (self.end_date - self.start_date).to_i
    value = self.category.daily_rate + self.category.car_insurance + self.category.third_party_insurance
    days * value
  end
end
