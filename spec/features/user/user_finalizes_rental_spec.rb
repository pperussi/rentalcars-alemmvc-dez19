require 'rails_helper'

feature 'User finalizes rental' do
  scenario 'successfully searches for rental' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    category = create(:category, name: 'Deluxe')
    car_model = create(:car_model, category: category)
    car = create(:car, car_model: car_model, status: :available)
    user = create(:user, role: :user, subsidiary: subsidiary)
    rental = create(:rental,:with_car, start_date: '3000-01-01', end_date: '3000-01-05',
                    status: :ongoing, category: category,
                    subsidiary: subsidiary, car: car)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'

    expect(page).to have_content(rental.reservation_code)
    expect(page).to have_content('Data de início: 01 de janeiro de 3000')
    expect(page).to have_content('Data de término: 05 de janeiro de 3000')
    expect(page).to have_content("Categoria: #{rental.category.name}")
    expect(page).to have_content("Locação de: #{rental.client.name}")
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content('R$ 200,00')
    expect(rental.reload).to be_ongoing
    expect(page).to have_content('Finalizar locação')
  end

  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    category = create(:category, name: 'Deluxe')
    car_model = create(:car_model, category: category)
    car = create(:car, car_model: car_model, status: :available)
    user = create(:user, role: :user, subsidiary: subsidiary)
    rental = create(:rental,:with_car, start_date: '3000-01-01', end_date: '3000-01-05',
                    status: :ongoing, category: category,
                    subsidiary: subsidiary, car: car)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'
    click_on 'Finalizar locação'

    expect(page).to have_content('Status: finalizada')
    expect(rental.reload).to be_finalized
  end

  scenario 'and must be ongoing rental' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    category = create(:category, name: 'Deluxe')
    car_model = create(:car_model, category: category)
    car = create(:car, car_model: car_model, status: :available)
    user = create(:user, role: :user, subsidiary: subsidiary)
    rental = create(:rental, start_date: '3000-01-01', end_date: '3000-01-05',
                    status: :scheduled, category: category,
                    subsidiary: subsidiary)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'

    expect(page).not_to have_button('Finalizar locação')
    expect(page).to have_button('Iniciar locação')
  end

  scenario 'and can be finalized by user in different subsidiary' do
    subsidiary = create(:subsidiary, name: 'Almeidinha Autos')
    other_subsidiary = create(:subsidiary, name: 'MoratoMotors')
    category = create(:category, name: 'Deluxe')
    car_model = create(:car_model, category: category)
    car = create(:car, car_model: car_model, status: :available)
    user = create(:user, role: :user, subsidiary: subsidiary)
    rental = create(:rental,:with_car, start_date: '3000-01-01', end_date: '3000-01-05',
                    status: :ongoing, category: category,
                    subsidiary: other_subsidiary, car: car)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'
    click_on 'Finalizar locação'

    expect(page).to have_content('Status: finalizada')
    expect(rental.reload).to be_finalized
  end
end
