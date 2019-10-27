require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:genre) }
end
