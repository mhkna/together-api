FactoryBot.define do
  factory :account do
    website { "instagram" }
    username { Faker::Internet.username(5..10) }
  end
end
