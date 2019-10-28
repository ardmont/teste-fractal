require 'rails_helper'

RSpec.describe 'Api::V1::Artists', type: :request do
  # Inicia os dados de teste utilizando a factory criada pelo factory_bot
  let!(:artists) { create_list(:artist, 45) }
  let(:artist_id) { artists.first.id }

  # Suíte de testes para GET /api/v1/artists
  describe 'GET /api/v1/artists' do
    # Faz requisições GET HTTP antes de cada exemplo
    before { get '/api/v1/artists' }

    it 'Retorna lista de artistas sem paginação' do
      # `json` é um helper que converte o corpo das respostas em json
      expect(json).not_to be_empty
      expect(json.size).to eq(30)
    end

    it 'Retorna status code 200 sem paginação' do
      expect(response).to have_http_status(200)
    end
  end

  # Suíte de testes para GET /api/v1/artists?page=2
  describe 'GET /api/v1/artists?page=2' do
    # Faz requisições GET HTTP antes de cada exemplo
    before { get '/api/v1/artists?page=2' }

    it 'Retorna lista de artistas com paginação' do
      # `json` é um helper que converte o corpo das respostas em json
      expect(json).not_to be_empty
      expect(json.size).to eq(15)
    end

    it 'Retorna status code 200 com paginação' do
      expect(response).to have_http_status(200)
    end
  end

  # Suíte de testes para GET /api/v1/artists/:id
  describe 'GET /api/v1/artists/:id' do
    before { get "/api/v1/artists/#{artist_id}" }

    context 'Quando existir registro' do
      it 'returna o artista' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(artist_id)
      end

      it 'returna status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando não existir registro' do
      let(:artist_id) { 100 }

      it 'returna status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Suíte de testes para POST /api/v1/artists
  describe 'POST /api/v1/artists' do
    # Payload válido
    let(:valid_payload) { { name: 'Test Artist', genre: 'Rock' } }

    context 'Quando o payload for válido' do
      before { post '/api/v1/artists', as: :json, params: valid_payload }

      it 'Cria um artista' do
        expect(json['name']).to eq('Test Artist')
      end

      it 'retorna status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Quando o payload não for válido' do
      # Requisião com com payload inválido. Está sem o gênero do artista.
      before { post '/api/v1/artists', as: :json, params: { name: 'Test Artist' } }

      it 'returna status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Suíte de testes para PUT /api/v1/artists/:id
  describe 'PUT /api/v1/artists/:id' do
    let(:valid_payload) { { genre: 'Samba' } }

    context 'Quando existir registro' do
      before { put "/api/v1/artists/#{artist_id}",  as: :json, params: valid_payload }

      it 'Atualiza o registro' do
        expect(json['genre']).to eq('Samba')
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Suíte de testes para DELETE /api/v1/artists/:id
  describe 'DELETE /api/v1/artists/:id' do
    before { delete "/api/v1/artists/#{artist_id}" }

    it 'retorna status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
