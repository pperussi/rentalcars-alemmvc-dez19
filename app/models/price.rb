class Price < ApplicationRecord
  validates :daily_rate, presence: true
end
