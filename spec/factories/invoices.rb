FactoryBot.define do
  factory :invoice do
    association :customer
    status { ['cancelled', 'completed', 'in progress'].sample }
    id { Faker::Number.unique.within(range: 1..1_000_000) }
  end
end
