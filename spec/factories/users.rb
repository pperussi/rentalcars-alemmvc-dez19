FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '12345678' }
    role { :user }
   end
end
