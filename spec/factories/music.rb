FactoryBot.define do
  factory :music do
    title { Faker::Lorem.sentence }
    genre { Faker::Music.genre }
    duration { Faker::Number.number(digits: 3) }
  end
end