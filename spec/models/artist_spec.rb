require 'rails_helper'

RSpec.describe Artist, type: :model do
  # Teste de associação
  # Verifica se o model Artist possui uma relação de 1:m com o model Album
  it { should have_many(:albums) }

  # Testes de validação
  # Verifica a presença dos campos name e genre
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:genre) }
end
