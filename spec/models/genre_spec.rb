require 'rails_helper'

RSpec.describe Genre, type: :model do
  # Teste de validação
  # Verifica a presença do campo name
  it { should validate_presence_of(:name) }
end
