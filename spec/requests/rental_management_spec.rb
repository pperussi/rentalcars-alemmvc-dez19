require 'rails_helper'

describe "Rentals", :type => :request do
  it 'should redirect to rental unless user from same subsidiary' do
    subsidiary = create(:subsidiary, name: 'Almeidinha Motors')
    other_subsidiary = create(:subsidiary, name: 'MoratoMotors' )
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                      cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    create(:car, car_model: car_model, license_plate: 'MVM-838',
                 subsidiary: subsidiary)
    create(:car, car_model: car_model, license_plate: 'TLA-090',
                 subsidiary: other_subsidiary)
    subsidiary = create(:subsidiary, name: 'Almeidinha Automóveis')
    user = create(:user, role: :user, subsidiary: subsidiary)
    fiat = create(:manufacture, name: 'Fiat')
    gasolina = create(:fuel_type, name: 'Gasolina')
    category = create(:category, name: 'A')
    car_model = create(:car_model, name: 'Sport', manufacture: fiat,
                                   fuel_type: gasolina, category: category)
    create(:car_model, name: 'Sedan', manufacture: fiat, fuel_type: gasolina,
                       category: category)
    create(:car, car_model: car_model, license_plate: 'TTT-9898',
                 subsidiary: other_subsidiary)
    rental = create(:rental, category: category, subsidiary: other_subsidiary,
                    start_date: '3000-01-08', end_date: '3000-01-10',
                    client: customer, status: :scheduled)
    login_as user, scope: :user

    post confirm_rental_path(rental)

    expect(response).to redirect_to(rental_path(rental))
  end
end
