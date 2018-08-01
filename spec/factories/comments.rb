FactoryBot.define do
  factory :comments do
    text { Faker::Lorem.sentence }
    account_id nil
  end
end
