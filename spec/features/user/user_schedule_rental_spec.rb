require 'rails_helper'

feature 'User schedules rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    find(:css, '.start_date').set('3000-01-01')
    find(:css, '.end_date').set('3000-01-07')
    find(:css, '#inputGroupSelect01').set('Claudionor')
    find(:css, '#inputGroupSelect02').set('A')
    click_on 'Agendar'

    expect(page).to have_css('h1', text: 'Locação de: Claudionor')
    expect(page).to have_css('h3', text: 'Status: agendada')
    expect(page).to have_css('p', text: 'cro@email.com')
    expect(page).to have_css('p', text: '318.421.176-43')
    expect(page).to have_css('p', text: '01 de janeiro de 3000')
    expect(page).to have_css('p', text: '07 de janeiro de 3000')
    expect(page).to have_css('p', text: 'Almeida Motors')
    expect(page).to have_css('p', text: 'Categoria: A')
    expect(page).to have_css('p', text: 'R$ 300,00')
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    find(:css, '.start_date').set('')
    find(:css, '.end_date').set('')
    find(:css, '#inputGroupSelect01').set('')
    find(:css, '#inputGroupSelect02').set('')
    click_on 'Agendar'

    expect(page).to have_content('Data de início deve ser definida')
    expect(page).to have_content('Data de término deve ser definida')
  end
end
