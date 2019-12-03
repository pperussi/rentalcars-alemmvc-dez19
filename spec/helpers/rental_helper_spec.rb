require 'rails_helper'

describe RentalHelper do
  describe '.status_badge' do
    it 'primary badge' do
      rental = build(:rental, status: :scheduled)

      result = helper.status_badge(rental)

      expect(result).to eq('<span class="badge badge-primary">agendada</span>')
    end

    it 'success badge' do
      rental = build(:rental, status: :finalized)

      result = helper.status_badge(rental)

      expect(result).to eq('<span class="badge badge-success">finalizada</span>')
    end
   end
end