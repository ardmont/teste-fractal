class Music < ApplicationRecord
  validates :title, :duration, :genre, presence: true
end
