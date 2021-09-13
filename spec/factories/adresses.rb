
FactoryBot.define do
  factory :address do
    zip_code { Faker::Address.zip_code }
    state { Faker::Address.state }
    city { Faker::Address.city }
    district { Faker::Address.community }
    street { Faker::Address.street_name }
    house_number { Faker::Address.building_number }
  end
end
