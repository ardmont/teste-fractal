FactoryBot.define do
  factory :album do
    title { Faker::Music.album }
    genre { FactoryBot.create :genre }
  end
end