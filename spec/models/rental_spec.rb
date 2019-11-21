require 'rails_helper'

RSpec.describe Rental, type: :model do
  context '#generate_random_token' do
    it 'should generate a random reservation code' do
      rental = build(:rental)

      expect(rental.send(:generate_random_token)).to match(/[0-9A-Z]{6}/)
    end
  end

  context '#generate_reservation_number' do
    it 'should generate a random reservation code on create' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
      customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
      manufacture = create(:manufacture, name: 'Fiat')
      fuel_type = create(:fuel_type)
      car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
      create(:car, car_model: car_model)
      rental = build(:rental, price_projection: 100, category: category,
                     subsidiary: subsidiary, client: customer)
      rental.save!

      expect(rental).to be_persisted
      expect(rental.reservation_code).to match(/[0-9A-Z]{6}/)
    end
  end
end
