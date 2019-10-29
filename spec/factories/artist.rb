FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    genre { FactoryBot.create :genre }
  end
end