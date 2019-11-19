class Rental < ApplicationRecord
  enum status: { scheduled: 0, ongoing: 2, finalized: 3 }
  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary
  validates :start_date, :end_date, :price_projection, presence: true
  validate :start_cannot_be_greater_than_end, :cars_available

  def calculate_price_projection
    return 0 unless self.start_date && self.end_date && self.category
    days = (self.end_date - self.start_date).to_i
    value =
      self.category.daily_rate +
      self.category.car_insurance +
      self.category.third_party_insurance
    days * value
  end

  def start_cannot_be_greater_than_end
    return 0 if self.start_date.nil? || self.end_date.nil?
    if self.start_date >= self.end_date
      errors.add(:start_date, 'não pode ser maior que data de término.')
    end
  end

  def cars_available
    if cars_available_at_date_range
      errors.add(:category, 'Não há carros disponíveis na categoria escolhida.')
    end
  end

  private

  def cars_available_at_date_range
    scheduled_rentals = Rental.where(start_date: self.start_date..self.end_date)
      .where(end_date: self.start_date..self.end_date)
      .where(category: self.category)
    available_cars_at_category = Car.where(status: :available).joins(:car_model)
      .where(car_models: { category: self.category })
    scheduled_rentals.count >= available_cars_at_category.count
  end
end
