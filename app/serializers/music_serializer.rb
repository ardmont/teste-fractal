class MusicSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :albums
  belongs_to :genre
end
