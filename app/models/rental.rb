class Rental < ApplicationRecord
  enum status: { scheduled: 0, ongoing: 2, finalized: 3 }
  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary
  validates :start_date, :end_date, :price_projection, presence: true
  validate :start_cannot_be_greater_than_end

  def calculate_price_projection
    return 0 unless self.start_date && self.end_date && self.category
    days = (self.end_date - self.start_date).to_i
    value = self.category.daily_rate + self.category.car_insurance + self.category.third_party_insurance
    days * value
  end

  def start_cannot_be_greater_than_end
    return 0 unless self.start_date && self.end_date
    if self.start_date >= self.end_date
      errors.add(:start_date, 'não pode ser maior que data de término.')
    end
  end
end
