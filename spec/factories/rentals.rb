FactoryBot.define do
  factory :rental do
    start_date { "2019-11-13" }
    end_date { "2019-11-13" }
    client { nil }
    category { nil }
    subsidiary { nil }
    status { 0 }
  end
end
