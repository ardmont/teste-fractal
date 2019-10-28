require 'rails_helper'

RSpec.describe "Api::V1::Artists", type: :request do
  # Inicia os dados de teste utilizando a factory criada pelo factory_bot
  let!(:artists) { create_list(:artist, 10) }
  let(:artist_id) { artists.first.id }

  describe "GET /api/v1/artists" do
    # Faz requisições GET HTTP antes de cada exemplo
    before { get '/api/v1/artists' }

    it 'Retorna lista de artistas' do
      # `json` é um helper que converte o corpo das respostas em json
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'Retorna status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
