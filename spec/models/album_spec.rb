require 'rails_helper'

RSpec.describe Album, type: :model do
  # Testes de associação
  # Verifica se o model Album possui uma relação de m:1 com o model Artist
  it { should belong_to(:artist) }
  # Verifica se o model Album possui uma relação de m:1 com o model Genre
  it { should belong_to(:genre) }
  # Verifica se o model Album possui uma relação de m:m com o model Music
  it { should have_and_belong_to_many(:musics) }

  # Testes de validação
  # Verifica a presença dos campos title e genre
  it { should validate_presence_of(:title) }
end
