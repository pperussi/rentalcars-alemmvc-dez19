require 'rails_helper'

feature 'User schedules rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    category = create(:category, name: 'A')
    create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    rental_price = create(:rental_price, daily_rate: 10,
                          daily_car_insurance: 20,
                          daily_third_party_insurance: 20,
                          subsidiary: subsidiary, category: category)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    find(:css, '.start_date').set('3000-01-01')
    find(:css, '.end_date').set('3000-01-07')
    find(:css, '#inputGroupSelect01').set('cro@email.com')
    find(:css, '#inputGroupSelect02').set('A')
    click_on 'Agendar'

    expect(page).to have_content('Locação agendada')
    expect(page).to have_css('p', text: 'Claudionor')
    expect(page).to have_css('p', text: 'cro@email.com')
    expect(page).to have_css('p', text: '318.421.176-43')
    expect(page).to have_css('p', text: '01 de janeiro de 3000')
    expect(page).to have_css('p', text: '07 de janeiro de 3000')
    expect(page).to have_css('p', text: 'Almeida Motors')
    expect(page).to have_css('p', text: 'Categoria A')
    expect(page).to have_css('p', text: 'R$ 350,00')
  end
end
