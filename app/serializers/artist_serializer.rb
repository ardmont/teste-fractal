class ArtistSerializer < ActiveModel::Serializer
  cache key: 'artist', expires_in: 3.hours
  attributes :id, :name
  has_many :albums
  belongs_to :genre
end
