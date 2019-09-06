require 'rails_helper'

feature 'User register price' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    address = create(:address, street: 'Av. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP', subsidiary: subsidiary)
    user = create(:user, role: :user, subsidiary: subsidiary)
    categ = create(:category, name: 'A')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Preços'
    click_on 'Registrar novo preço'

    select 'A', from: 'Categoria'
    fill_in 'Preço', with: '50.00'
    click_on 'Enviar'

    expect(page).to have_content('Categoria')
    expect(page).to have_content('A')
    expect(page).to have_content('Preço')
    expect(page).to have_content('R$ 50,00')
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    address = create(:address, street: 'Av. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP', subsidiary: subsidiary)
    user = create(:user, role: :user, subsidiary: subsidiary)
    categ = create(:category, name: 'A')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Preços'
    click_on 'Registrar novo preço'

    click_on 'Enviar'

    expect(page).to have_content('Preço não pode ficar em branco')
  end
end