class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :artist
  belongs_to :genre
  has_many :musics
end
