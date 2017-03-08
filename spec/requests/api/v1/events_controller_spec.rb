require 'rails_helper'

RSpec.describe 'Events API/V1', type: :request do
	describe 'GET /events/:id' do
		context 'when event exist' do
			before do
				@event = create :event
				get "/api/v1/events/#{@event.id}"
			end

			it 'responds with 200 HTTP status code' do
				expect(response).to have_http_status 200
			end

			it 'responds with not empty json' do
				expect(json).to_not be_empty
				expect(json.size).to eql 9
			end

		end

		context 'when event does not exist' do
			before { get "/api/v1/events/100" }

			it 'responds with 404 HTTP status code' do
				expect(response).to have_http_status 404
			end
		end
	end

	describe 'GET /events' do
		context 'when events exist' do
			before do
				@event1 = create :event
				@event2 = create :event
				get "/api/v1/events"
			end

			it 'responds with 200 HTTP status code' do
				expect(response).to have_http_status 200
			end

			it 'responds with all events' do
				expect(json.size).to eql 2
			end

		end

		context 'when events does not exist' do
			before { get "/api/v1/events" }

			it 'responds with 200 HTTP status code' do
				expect(response).to have_http_status 200
			end

			it 'responds with empty list of events' do
				expect(json).to be_empty 
			end
		end
	end

	describe 'POST /events' do
		let(:valid_parameters) do
			{
				eventType: 'event type', name: 'Event name', startAt: (DateTime.now + 1.day).to_s,
				endAt: (DateTime.now + 2.day).to_s, place: 'my place', status: 'new'
			}.to_json
		end

		let(:invalid_parameters) do
			{
				eventType: 'event type', name: nil, startAt: '2000-01-02T08:00:00.000Z',
				endAt: '2000-01-01T08:00:00.000Z', place: 'my place', status: 'new'
			}.to_json
		end

		context 'when valid parameters' do
			it 'responds with 201 HTTP status code' do
				post '/api/v1/events', params: valid_parameters
				expect(response).to have_http_status(201)
			end

			it 'creates event' do
				expect do
					post '/api/v1/events', params: valid_parameters
				end.to change { Event.count }.by 1 
			end

			it 'responds with json' do
				post '/api/v1/events', params: valid_parameters
				expect(json[:name]).to eql 'Event name'
			end
		end

		context 'when valid parameters' do
			it 'responds with 422 HTTP status code' do
				post '/api/v1/events', params: invalid_parameters
				expect(response).to have_http_status(422)
			end

			it 'does not create event' do
				expect do
					post '/api/v1/events', params: invalid_parameters
				end.to change { Event.count }.by 0 
			end

			it 'responds with errors inside json' do
				post '/api/v1/events', params: invalid_parameters
				expect(json[:errors]).to_not be_empty
			end
		end
	end
end