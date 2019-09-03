require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    user = create(:user, role: :user)
    login_as user, scope: :user
    
    visit root_path
    click_on 'Registrar novo cliente'
    fill_in 'Nome', with: 'Apolônio'
    fill_in 'CPF', with: '632.254.740-29'
    fill_in 'E-mail', with: 'apolonio@email.com'
    fill_in 'Logradouro', with: 'Vila do Chaves'
    fill_in 'Número', with: '71'
    fill_in 'Complemento', with: 'Dentro do barril'
    fill_in 'Bairro', with: 'México'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Registrar cliente'

    expect(page).to have_content('Apolônio')
    expect(page).to have_content('632.254.740-29')
    expect(page).to have_content('apolonio@email.com')
    expect(page).to have_content('Vila do Chaves, nº 71')
    expect(page).to have_content('Dentro do barril')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end
end
