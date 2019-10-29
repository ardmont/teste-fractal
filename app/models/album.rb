class Album < ApplicationRecord
  belongs_to :artist
  belongs_to :genre
  has_and_belongs_to_many :musics
  validates :title, presence: true
end
