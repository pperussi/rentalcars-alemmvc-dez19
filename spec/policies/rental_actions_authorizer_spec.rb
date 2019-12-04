require 'rails_helper'

describe RentalActionsAuthorizer do
  describe '#authorized?' do

    it 'should authorize admin' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, subsidiary: subsidiary, role: :admin)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                      category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
                      subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: 1.day.from_now, end_date: 10.days.from_now,
                      status: :finalized)
      
      expect(described_class.new(rental, user)).to be_authorized
    end

    it 'should not authorize some subsidiary users' do
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
                      status: :finalized)
      
      expect(described_class.new(rental, user)).to be_authorized
    end

    it 'should not authorize another subsidiary users' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      another_subsidiary = create(:subsidiary, name: 'Outra Motors')
      user = create(:user, subsidiary: another_subsidiary)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                      category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
                      subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: 1.day.from_now, end_date: 10.days.from_now,
                      status: :finalized)
      
      expect(described_class.new(rental, user)).not_to be_authorized
    end
  end
end