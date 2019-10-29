require 'rails_helper'

RSpec.describe "Api::V1::Musics", type: :request do
  # Inicia os dados de teste utilizando a factory criada pelo factory_bot
  let!(:genres) { create_list(:genre, 10) } # Cria 10 gêneros
  let(:genre_id) { genres.sample.id } # Pega um gênero aleatório para ser associado à musica
  let!(:musics) { create_list(:music, 45) } # Cria 45 músicas
  let(:music_sample) { musics.first } # Pega a primeira música para ser usada como amostra nos testes
  let(:music_sample_id) { music_sample.id }

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

    context 'GET /api/v1/musics?title=[title]' do 
      # Faz requisições GET HTTP antes de cada exemplo
      before { get "/api/v1/musics?title=#{music_sample.title}" }
      
      it 'retorna a musica pelo título especificado' do
        expect(json).not_to be_empty
        expect(json[0]['title']).to eq(music_sample.title)
      end

      it 'retorna status code 200 após consulta por nome' do
        expect(response).to have_http_status(200)
      end
    end

    context 'GET /api/v1/musics?genre_id=[genre_id]' do 
      # Faz requisições GET HTTP antes de cada exemplo
      before { get "/api/v1/musics?genre_id=#{music_sample.genre_id}" }
      
      it 'retorna as musicas pelo gênero especificado' do
        expect(json).not_to be_empty
        expect(json[0]['genre_id']).to eq(music_sample.genre_id)
      end

      it 'retorna status code 200 após consulta por gênero' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Suíte de testes para GET /api/v1/musics/:id
  describe 'GET /api/v1/musics/:id' do
    before { get "/api/v1/musics/#{music_sample_id}" }

    context 'Quando existir registro' do
      it 'retorna o musica' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(music_sample_id)
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando não existir registro' do
      let(:music_sample_id) { 100 }

      it 'retorna status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Suíte de testes para POST /api/v1/musics
  describe 'POST /api/v1/musics' do
    # Payload válido
    let(:valid_payload) { { title: 'Test Music', genre_id: genre_id, duration: 350 } }

    context 'Quando o payload for válido' do
      before { post '/api/v1/musics', as: :json, params: valid_payload }

      it 'Cria um musica' do
        expect(json['title']).to eq('Test Music')
      end

      it 'retorna status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Quando o payload não for válido' do
      # Requisião com com payload inválido. Está sem o título da musica.
      before { post '/api/v1/musics', as: :json, params: { genre_id: genre_id, duration: 350 } }

      it 'retorna status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Suíte de testes para PUT /api/v1/musics/:id
  describe 'PUT /api/v1/musics/:id' do
    let(:valid_payload) { { title: 'New title' } }

    context 'Quando existir registro' do
      before { put "/api/v1/musics/#{music_sample_id}",  as: :json, params: valid_payload }

      it 'Atualiza o registro' do
        expect(json['title']).to eq('New title')
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Suíte de testes para DELETE /api/v1/musics/:id
  describe 'DELETE /api/v1/musics/:id' do
    before { delete "/api/v1/musics/#{music_sample_id}" }

    it 'retorna status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
