FactoryBot.define do
  factory :professional do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraphs }
    email { Faker::Internet.email }
    cell_phone { Faker::PhoneNumber.cell_phone }
  end
end

