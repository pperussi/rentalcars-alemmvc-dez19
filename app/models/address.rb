class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, presence: { message: 'Logradouro não pode ficar em '\
                                          'branco' }
  validates :number, presence: { message: 'Número não pode ficar em branco' }
  validates :neighborhood, presence: { message: 'Bairro não pode ficar em '\
                                                'branco' }
  validates :city, presence: { message: 'Cidade não pode ficar em branco' }
  validates :state, presence: { message: 'Estado não pode ficar em branco' }

  def label
    "#{street},  nº #{number}"
  end
end
