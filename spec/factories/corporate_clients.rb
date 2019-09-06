FactoryBot.define do
  factory :corporate_client do
    trade_name { "Empresa Ficticia" }
    cnpj { "0000.000.00.000" }
    email { "email@ficticio.com" }
    adress { nil }
    type { "" }
  end
end
