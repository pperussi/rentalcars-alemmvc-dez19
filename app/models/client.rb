class Client < ApplicationRecord
  has_one :address, as: :addressable
end
