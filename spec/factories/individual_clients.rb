FactoryBot.define do
  factory :individual_client do
    name { "NomeFictício" }
    cpf { "000.000.000" }
    email { "email@ficticio.com" }
    address { nil }
    type { "" }
  end
end
