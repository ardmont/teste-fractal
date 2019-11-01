class AlbumSerializer < ActiveModel::Serializer
  cache key: 'album', expires_in: 3.hours
  attributes :id, :title, :favorite
  belongs_to :artist
  belongs_to :genre
  has_many :musics
end
