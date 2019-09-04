FactoryBot.define do
  factory :car_model do
    name { "MyString" }
    year { "MyString" }
    manufacture { nil }
    motorization { "MyString" }
    fuel_type { nil }
    category { "MyString" }
    car_options { "MyText" }
  end
end
