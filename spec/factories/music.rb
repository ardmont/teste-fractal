FactoryBot.define do
  factory :music do
    title { Faker::Lorem.sentence }
    genre { Faker::Music.genre }
    duration { Faker::Number.number(digits: 10) }
  end
end