require 'rails_helper'

RSpec.describe Artist, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:genre) }
end
