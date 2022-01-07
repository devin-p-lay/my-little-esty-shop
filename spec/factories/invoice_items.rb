FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { Faker::Number.within(range: 1..1000) }
    unit_price { Faker::number.within(range: 1..1000) }
    status { [0,1,2].sample }
    id { Faker::Number.unique.within(range: 1..1_000_000) }
  end
end
