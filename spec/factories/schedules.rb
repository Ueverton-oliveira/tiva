FactoryBot.define do
  factory :schedule do
    initial_date { Faker::Date.between }
    end_date { Faker::Date.between }
    initial_hour { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    end_hour { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end
