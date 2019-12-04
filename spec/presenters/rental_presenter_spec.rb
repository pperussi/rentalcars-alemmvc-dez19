require 'rails_helper'

describe RentalPresenter do
  describe '#status' do
    it 'should render primary badge' do
      user = create(:user)
      rental = build(:rental, status: :scheduled)
      result = RentalPresenter.new(rental, user).status_badge

      expect(result).to eq('<span class="badge badge-primary">agendada</span>')
    end
  end

  describe '#status' do
  include Rails.application.routes.url_helpers

    it 'should return start rental' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, subsidiary: subsidiary)
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

      expect(result).to eq("<a href=\"#{review_rental_path(rental)}\">Iniciar Locação</a>")
    end
  end

  describe '#status' do
  include Rails.application.routes.url_helpers

    it 'should return closure rental' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, subsidiary: subsidiary)

      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                      category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
                      subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: 1.day.from_now, end_date: 10.days.from_now,
                      status: :ongoing)

      result = RentalPresenter.new(rental, user).current_action

      expect(result).to eq("<a href=\"#{closure_review_rental_path(rental)}\">Encerrar Locação</a>")
    end
  end

  describe '#status' do
  include Rails.application.routes.url_helpers

    it 'should return continue rental' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, subsidiary: subsidiary)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                      category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
                      subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: 1.day.from_now, end_date: 10.days.from_now,
                      status: :in_review)

      result = RentalPresenter.new(rental, user).current_action

      expect(result).to eq("<a href=\"#{review_rental_path(rental)}\">Continuar Locação</a>")
    end

    it 'should return report rental to admins' do
      user = create(:user, role: :admin)
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                      category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
                      subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: 1.day.from_now, end_date: 10.days.from_now,
                      status: :finalized)

      result = RentalPresenter.new(rental, user).current_action
      
      expect(result).to eq("<a href=\"#{report_rental_path(rental)}\">Reportar Problema</a>")
    end
  end
end
