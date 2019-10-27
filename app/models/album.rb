class Album < ApplicationRecord
  belongs_to :artist
  has_and_belongs_to_many :musics
  validates :title, :genre, presence: true
end
