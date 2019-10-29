class Music < ApplicationRecord
  has_and_belongs_to_many :albums
  belongs_to :genre
  validates :title, :duration, presence: true
end
