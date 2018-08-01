FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    account_id nil
  end
end
