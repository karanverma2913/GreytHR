FactoryBot.define do
  factory :employee do
    name { 'John' }
    email { "#{Faker::Name.first_name}@gmail.com" }
    password { Faker::Internet.password(min_length: 8) }
    role { "developer" }
    joining_date { Faker::Date.between(from: '2023-01-01', to: '2023-06-01') }
    salary { 10000 }
    balance { 12.0 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
