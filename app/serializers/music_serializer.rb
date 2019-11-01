class MusicSerializer < ActiveModel::Serializer
  cache key: 'music', expires_in: 3.hours
  attributes :id, :title
  has_many :albums
  belongs_to :genre
end
