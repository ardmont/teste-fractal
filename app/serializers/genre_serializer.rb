class GenreSerializer < ActiveModel::Serializer
  cache key: 'genre', expires_in: 3.hours
  attributes :id, :name
  has_many :artists
  has_many :musics
  has_many :albums
end
