FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email 'tom@tom.com'
    password 'tomtom'
  end
end
