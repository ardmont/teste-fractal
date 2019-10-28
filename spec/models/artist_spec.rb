require 'rails_helper'

RSpec.describe Artist, type: :model do
  # Testes de associação
  # Verifica se o model Artist possui uma relação de m:1 com o model Genre
  it { should belong_to(:genre) }
  # Verifica se o model Artist possui uma relação de 1:m com o model Album
  it { should have_many(:albums) }

  # Teste de validação
  # Verifica a presença dos campo name
  it { should validate_presence_of(:name) }
end
