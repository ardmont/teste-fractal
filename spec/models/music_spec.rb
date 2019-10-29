require 'rails_helper'

RSpec.describe Music, type: :model do
  # Testes de associação
  # Verifica se o model Music possui uma relação de m:1 com o model Genre
  it { should belong_to(:genre) }
  # Verifica se o model Music possui uma relação de m:m com o model Album
  it { should have_and_belong_to_many (:albums) }

  # Testes de validação
  # Verifica a presença dos campos title e genre
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:duration) }
end
