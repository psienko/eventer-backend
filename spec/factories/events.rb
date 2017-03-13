FactoryGirl.define do
  factory :event do
    sequence(:name) { |n| "weeding #{n}" }
    event_type 'weeding'
    start_at DateTime.now + 1.day
    end_at DateTime.now + 2.day
    place 'Warsaw'
    status 'new'
  end
end