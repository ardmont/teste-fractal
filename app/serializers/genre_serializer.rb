class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :artists
  has_many :musics
  has_many :albums
end
