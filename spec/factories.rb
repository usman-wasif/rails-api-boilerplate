FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '112233' }
  end

  factory :vehicle do
    cms_vehicle_id { Faker::Alphanumeric.alphanumeric(number: 6) }
    model { Faker::Vehicle.model }
    make { Faker::Vehicle.manufacture }
  end

  factory :reservation do
    date { Faker::Date.forward(days: 10).to_s }
    time { '11:30' }
    vehicle
    customer
  end

  factory :customer do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    cms_customer_id { Faker::Alphanumeric.alphanumeric(number: 6) }
  end
end
