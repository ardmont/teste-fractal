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

  # Suíte de testes para GET /api/v1/musics/:id
  describe 'GET /api/v1/musics/:id' do
    before { get "/api/v1/musics/#{music_id}" }

    context 'Quando existir registro' do
      it 'retorna o musica' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(music_id)
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando não existir registro' do
      let(:music_id) { 100 }

      it 'retorna status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Suíte de testes para POST /api/v1/musics
  describe 'POST /api/v1/musics' do
    # Payload válido
    let(:valid_payload) { { title: 'Test Music', genre: 'Rock', duration: 350 } }

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
      # Requisião com com payload inválido. Está sem o gênero da musica.
      before { post '/api/v1/musics', as: :json, params: { title: 'Test Music', duration: 350 } }

      it 'retorna status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Suíte de testes para PUT /api/v1/musics/:id
  describe 'PUT /api/v1/musics/:id' do
    let(:valid_payload) { { genre: 'Samba' } }

    context 'Quando existir registro' do
      before { put "/api/v1/musics/#{music_id}",  as: :json, params: valid_payload }

      it 'Atualiza o registro' do
        expect(json['genre']).to eq('Samba')
      end

      it 'retorna status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Suíte de testes para DELETE /api/v1/musics/:id
  describe 'DELETE /api/v1/musics/:id' do
    before { delete "/api/v1/musics/#{music_id}" }

    it 'retorna status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
