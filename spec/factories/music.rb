FactoryBot.define do
  factory :music do
    title { Faker::Lorem.sentence }
    genre { FactoryBot.create :genre }
    duration { Faker::Number.number(digits: 3) }
  end
end