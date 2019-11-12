User.create(email: 'user@email.com', password: '123456', role: :user)
User.create(email: 'admin@email.com', password: '123456', role: :admin)
Category.create(name: 'A', daily_rate: 50.0, car_insurance: 50.0,
           third_party_insurance: 50.0)
Category.create(name: 'B', daily_rate: 50.0, car_insurance: 50.0,
           third_party_insurance: 50.0)
Category.create(name: 'C', daily_rate: 50.0, car_insurance: 50.0,
           third_party_insurance: 50.0)
Manufacture.create(name: 'Fiat')
Manufacture.create(name: 'Ford')
FuelType.create(name: 'Gasolina')
FuelType.create(name: 'Álcool')
