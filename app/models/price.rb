class Price < ApplicationRecord
  belongs_to :category
  belongs_to :subsidiary

  validates :daily_rate, presence: true
end
