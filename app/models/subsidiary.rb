class Subsidiary < ApplicationRecord
  has_one :address
  accepts_nested_attributes_for :address

  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :cnpj, presence: { message: 'CNPJ não pode ficar em branco' }
end
