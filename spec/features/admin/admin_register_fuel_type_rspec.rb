require 'rails_helper'

feature 'Admin register fuel type' do
  scenario 'successfully' do
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit new_fuel_type_path
    fill_in 'Combustível', with: 'Gasolina'
    click_on 'Enviar'

    expect(page).to have_content('Gasolina')
  end

  scenario 'and must fill in name' do
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit new_fuel_type_path
    fill_in 'Combustível', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Combustível não pode ficar em branco')
  end
  
end
