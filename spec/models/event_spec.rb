require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do 
  	context 'when invalid' do
  		it 'returns false when finish date is lower than start date' do
  			event = build :event, start_at: DateTime.now + 2.days, end_at: DateTime.now + 1.day
  			expect(event).not_to be_valid
  		end

  		it 'returns false when start date is past and event is not finished' do
  			event = build :event, start_at: DateTime.now - 2.days
  			expect(event).not_to be_valid
  		end

  		it 'returns false when name is blank' do
  			event = build :event, name: nil
  			expect(event).not_to be_valid
  		end

  		it 'returns false when place is blank' do
  			event = build :event, place: nil
  			expect(event).not_to be_valid
  		end

  		it 'returns false when name is longer than 250 characters' do
  			event = build :event, name: 'a' * 251
  			expect(event).not_to be_valid
  		end

  		it 'returns false when place is longer than 250 characters' do
  			event = build :event, place: 'a' * 251
  			expect(event).not_to be_valid
  		end

  		it 'returns false when type is longer than 50 characters' do
  			event = build :event, type: 'a' * 51
  			expect(event).not_to be_valid
  		end
  	end

  	context 'when valid' do
  		it 'returns true when finish date is greate than start date' do
  			event = build :event, start_at: DateTime.now + 1.days, end_at: DateTime.now + 2.day
  			expect(event).to be_valid
  		end

  		it 'returns true when finish date is the same as start date' do
  			date = DateTime.now + 1.days
  			event = build :event, start_at: date, end_at: date
  			expect(event).to be_valid
  		end

  		it 'returns true when start date is past and event is finished' do
  			event = build :event, start_at: DateTime.now - 2.days, status: :finished
  			expect(event).to be_valid
  		end

  		it 'returns true when name and place are not blank' do
  			event = build :event, name: 'text', place: 'text2'
  			expect(event).to be_valid
  		end

  		it 'returns true when name is not longer than 250 characters' do
  			event = build :event, name: 'a' * 250
  			expect(event).to be_valid
  		end

  		it 'returns true when place is not longer than 250 characters' do
  			event = build :event, place: 'a' * 250
  			expect(event).to be_valid
  		end

  		it 'returns true when type is not longer than 50 characters' do
  			event = build :event, type: 'a' * 50
  			expect(event).to be_valid
  		end
  	end
  end
end
