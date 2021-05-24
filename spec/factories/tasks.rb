FactoryBot.define do
  factory :task do
    title {'test task'}
    start_at {Time.now}
    end_at {Time.now}
    all_day {true}
  end
end