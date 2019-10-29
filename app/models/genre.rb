class Genre < ApplicationRecord
  has_many :artists
  has_many :musics
  has_many :albums
  validates :name, presence: true
end
