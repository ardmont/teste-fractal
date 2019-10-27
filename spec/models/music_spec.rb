require 'rails_helper'

RSpec.describe Music, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:genre) }
end
