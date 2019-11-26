FactoryBot.define do
  factory :rental do
    start_date { "2019-11-13" }
    end_date { "2019-11-13" }
    client
    category
    subsidiary
    status { 0 }

    trait :with_car do
      transient do
        car { create(:car) }
      end

      after(:create) do |rental, evaluator|
        create(:rental_item, rental: rental, daily_rate: 50.0, rentable: evaluator.car)
      end
    end

    trait :without_callbacks do
      after(:build) do |rental|
        rental.class.skip_callback(:create, :generate_reservation_code)
      end

      after(:create) do |rental|
        rental.class.set_callback(:create, :generate_reservation_code)
      end
    end
  end
end
