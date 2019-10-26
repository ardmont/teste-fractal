class Artist < ApplicationRecord
  validates :name, :genre, presence: true
end
