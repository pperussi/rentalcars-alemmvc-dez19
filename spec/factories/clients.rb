FactoryBot.define do
  factory :client do
    name { "MyString" }
    cnpj { "MyString" }
    cpf { "MyString" }
    email { "MyString" }
    adress { nil }
    type { "" }
  end
end
