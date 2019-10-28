FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    genre { Faker::Music.genre }
  end
end