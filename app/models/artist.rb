class Artist < ApplicationRecord
  has_many :albums
  validates :name, :genre, presence: true
end
