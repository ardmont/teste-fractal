require 'rails_helper'

RSpec.describe "Api::V1::Albums", type: :request do
  # Inicia os dados de teste utilizando as factories criadas pelo factory_bot
  let!(:genres) { create_list(:genre, 10) } # Cria 10 gêneros
  let(:genre_id) { genres.sample.id } # Pega um gênero aleatório para ser associado ao álbum
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

  # Suíte de testes para GET /api/v1/albums/:id
  describe 'GET /api/v1/albums/:id' do
    before { get "/api/v1/albums/#{album_id}" }

    context 'Quando existir registro' do
      it 'retorna o álbum' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(album_id)
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando não existir registro' do
      let(:album_id) { 100 }

      it 'retorna status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Suíte de testes para POST /api/v1/albums
  describe 'POST /api/v1/albums' do
    # Payload válido
    let(:valid_payload) { { title: 'Test Album', genre_id: genre_id, artist_id: artist_id } }

    context 'Quando o payload for válido' do
      before { post '/api/v1/albums', as: :json, params: valid_payload }

      it 'Cria um album' do
        expect(json['title']).to eq('Test Album')
      end

      it 'retorna status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Quando o payload não for válido' do
      # Requisião com com payload inválido. Está sem o título do album.
      before { post '/api/v1/albums', as: :json, params: { genre_id: genre_id, artist_id: artist_id } }

      it 'retorna status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Suíte de testes para PUT /api/v1/albums/:id
  describe 'PUT /api/v1/albums/:id' do
    let(:valid_payload) { { title: 'New title' } }

    context 'Quando existir registro' do
      before { put "/api/v1/albums/#{album_id}",  as: :json, params: valid_payload }

      it 'Atualiza o registro' do
        expect(json['title']).to eq('New title')
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Suíte de testes para DELETE /api/v1/albums/:id
  describe 'DELETE /api/v1/albums/:id' do
    before { delete "/api/v1/albums/#{album_id}" }

    it 'retorna status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
