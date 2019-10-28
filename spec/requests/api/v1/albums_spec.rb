require 'rails_helper'

RSpec.describe "Api::V1::Albums", type: :request do
  # Inicia os dados de teste utilizando as factories criadas pelo factory_bot
  let!(:artists) { create_list(:artist, 10) } # Cria 10 artistas
  let(:artist_id) { artists.sample.id } # Pega um artista aleatório para ser usado no álbum
  let!(:albums) { create_list(:album, 45, artist_id: artist_id) } # Cria 45 álbums
  let(:album_id) { albums.first.id } # Pega o id do primeiro álbum da lista

  # Suíte de testes para GET /api/v1/albums
  describe 'GET /api/v1/albums' do
    context 'GET /api/v1/albums' do
      # Faz requisições GET HTTP antes de cada exemplo
      before { get '/api/v1/albums' }

      it 'Retorna lista de álbums sem paginação' do
        # `json` é um helper que converte o corpo das respostas em json
        expect(json).not_to be_empty
        expect(json.size).to eq(30)
      end

      it 'Retorna status code 200 sem paginação' do
        expect(response).to have_http_status(200)
      end
    end

    context 'GET /api/v1/albums?page=2' do
      # Faz requisições GET HTTP antes de cada exemplo
      before { get '/api/v1/albums?page=2' }

      it 'Retorna lista de álbums com paginação' do
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
