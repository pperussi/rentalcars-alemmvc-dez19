class CorporateClient < Client
  validates :email, presence: true
  validates :trade_name, presence: true
  validates :cnpj, presence: true
end
