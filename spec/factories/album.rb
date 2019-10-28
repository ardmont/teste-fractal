FactoryBot.define do
  factory :album do
    title { Faker::Music.album }
    genre { Faker::Music.genre }
  end
end