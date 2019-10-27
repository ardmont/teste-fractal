class Music < ApplicationRecord
  has_and_belongs_to_many :albums
  validates :title, :duration, :genre, presence: true
end
