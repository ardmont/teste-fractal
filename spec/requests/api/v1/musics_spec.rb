require 'rails_helper'

RSpec.describe "Api::V1::Musics", type: :request do
  # Inicia os dados de teste utilizando a factory criada pelo factory_bot
  let!(:musics) { create_list(:music, 45) }
  let(:music_id) { musics.first.id }

  # Suíte de testes para GET /api/v1/musics
  describe 'GET /api/v1/musics' do
    context 'GET /api/v1/musics' do
      # Faz requisições GET HTTP antes de cada exemplo
      before { get '/api/v1/musics' }

      it 'Retorna lista de músicas sem paginação' do
        # `json` é um helper que converte o corpo das respostas em json
        expect(json).not_to be_empty
        expect(json.size).to eq(30)
      end

      it 'Retorna status code 200 sem paginação' do
        expect(response).to have_http_status(200)
      end
    end

    context 'GET /api/v1/musics?page=2' do
      # Faz requisições GET HTTP antes de cada exemplo
      before { get '/api/v1/musics?page=2' }

      it 'Retorna lista de músicas com paginação' do
        # `json` é um helper que converte o corpo das respostas em json
        expect(json).not_to be_empty
        expect(json.size).to eq(15)
      end

      it 'Retorna status code 200 com paginação' do
        expect(response).to have_http_status(200)
      end
    end
  end


end
