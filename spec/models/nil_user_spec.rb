require 'rails_helper'

describe NilUser do
  it 'should return ' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = nil
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                    third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan',
                     category: category)
    create(:car, car_model: car_model, license_plate: 'TAT-1234',
                    subsidiary: subsidiary)
    rental = create(:rental, category: category, subsidiary: subsidiary,
                    start_date: 1.day.from_now, end_date: 10.days.from_now,
                    client: customer, status: :scheduled)

    result = RentalPresenter.new(rental, user).current_action

    expect(result).to eq('')
  end
end