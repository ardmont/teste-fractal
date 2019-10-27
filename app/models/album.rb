class Album < ApplicationRecord
  validates :title, :genre, presence: true
end
