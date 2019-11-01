require 'rails_helper'

RSpec.describe 'Api::V1::Artists', type: :request do
  # Inicia os dados de teste utilizando a factory criada pelo factory_bot
  let!(:genres) { create_list(:genre, 10) } # Cria 10 gêneros
  let(:genre_sample) { genres.sample } # Pega um gênero aleatório para ser associado ao artista
  let!(:artists) { create_list(:artist, 45) } # Cria 45 artistas
  let(:artist_sample) { artists.sample } # Pega um artista aleatório para ser usado como amostra nos testes
  let(:artist_sample_id) { artist_sample.id }

  # Suíte de testes para GET /api/v1/artists
  describe 'GET /api/v1/artists' do
    context 'GET /api/v1/artists' do
      # Faz requisições GET HTTP antes de cada exemplo
      before { get '/api/v1/artists' }

      it 'retorna lista de artistas após consulta sem paginação' do
        # `json` é um helper que converte o corpo das respostas em json
        expect(json).not_to be_empty
        expect(json.size).to eq(30)
      end

      it 'retorna status code 200 após consulta sem paginação' do
        expect(response).to have_http_status(200)
      end
    end

    context 'GET /api/v1/artists?page=2' do
      # Faz requisições GET HTTP antes de cada exemplo
      before { get '/api/v1/artists?page=2' }

      it 'retorna lista de artistas após consulta com paginação' do
        # `json` é um helper que converte o corpo das respostas em json
        expect(json).not_to be_empty
        expect(json.size).to eq(15)
      end

      it 'retorna status code 200 após consulta com paginação' do
        expect(response).to have_http_status(200)
      end
    end

    context 'GET /api/v1/artists?name_eq=[name]' do 
      # Faz requisições GET HTTP antes de cada exemplo
      before { get "/api/v1/artists?name_eq=#{artist_sample.name}" }
      
      it 'retorna o artista pelo nome especificado' do
        expect(json).not_to be_empty
        expect(json[0]['name']).to eq(artist_sample.name)
      end

      it 'retorna status code 200 após consulta por nome' do
        expect(response).to have_http_status(200)
      end
    end

    context 'GET /api/v1/artists?genre_id_eq=[genre_id]' do 
      # Faz requisições GET HTTP antes de cada exemplo
      before { get "/api/v1/artists?genre_id_eq=#{artist_sample.genre.id}" }
      
      it 'retorna os artistas pelo gênero especificado' do
        expect(json).not_to be_empty
        expect(json[0]['genre']['name']).to eq(artist_sample.genre.name)
      end

      it 'retorna status code 200 após consulta por gênero' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Suíte de testes para GET /api/v1/artists/:id
  describe 'GET /api/v1/artists/:id' do
    before { get "/api/v1/artists/#{artist_sample_id}" }

    context 'Quando existir registro' do
      it 'retorna o artista' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(artist_sample_id)
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando não existir registro' do
      let(:artist_sample_id) { 100 }

      it 'retorna status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Suíte de testes para POST /api/v1/artists
  describe 'POST /api/v1/artists' do
    # Payload válido
    let(:valid_payload) { { name: 'Test Artist', genre_id: genre_sample.id } }

    context 'Quando o payload for válido' do
      before { post '/api/v1/artists', as: :json, params: valid_payload }

      it 'cria um artista' do
        expect(json['name']).to eq('Test Artist')
      end

      it 'retorna status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Quando o payload não for válido' do
      # Requisião com com payload inválido. Está sem o nome do artista.
      before { post '/api/v1/artists', as: :json, params: { genre_id: genre_sample.id } }

      it 'retorna status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Suíte de testes para PUT /api/v1/artists/:id
  describe 'PUT /api/v1/artists/:id' do
    let(:valid_payload) { { name: 'New name' } }

    context 'Quando existir registro' do
      before { put "/api/v1/artists/#{artist_sample_id}",  as: :json, params: valid_payload }

      it 'Atualiza o registro' do
        expect(json['name']).to eq('New name')
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Suíte de testes para DELETE /api/v1/artists/:id
  describe 'DELETE /api/v1/artists/:id' do
    before { delete "/api/v1/artists/#{artist_sample_id}" }

    it 'retorna status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
