class Genre < ApplicationRecord
  has_many :artists
  has_many :musics
  validates :name, presence: true
end
