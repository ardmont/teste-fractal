class Api::V1::MusicsController < ApplicationController
  before_action :set_music, only: [:show, :update, :destroy]

  # GET /api/v1/musics
  def index
    # Busca todos as musicas, com paginação de 30 elementos por página e faz eager loading com Albums
    musics = Music.includes(:albums, :genre).paginate(page: params[:page], per_page: 30)

    # Este array armazenará os artistas e será utilizado como resposta
    response = []

    musics.each do |music|
      # Serializa o objeto music para posteriormente adicionar os álbums relacionados a música
      music_as_json = music.as_json

      # Adiciona os álbums relacionados a música ao json que será enviado
      music_as_json["albums"] = music.albums

      # Adiciona o gênero da musica ao json que será enviado
      music_as_json["genre"] = music.genre

      response << music_as_json
    end

    render json: response
  end

  # GET /api/v1/musics/:id
  def show
    # Serializa o objeto music para posteriormente adicionar os álbums relacionados a música
    music_as_json = @music.as_json

    # Adiciona os álbums relacionados a música ao json que será enviado
    music_as_json["albums"] = @music.albums

    # Adiciona o gênero da musica ao json que será enviado
    music_as_json["genre"] = @music.genre
    
    render json: music_as_json
  end

  # POST /api/v1/musics
  def create
    @music = Music.new(music_params)

    if @music.save
      render json: @music, status: :created
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/musics/:id
  def update
    if @music.update(music_params)
      render json: @music
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/musics/:id
  def destroy
    @music.destroy
  end

  private
    # Procura e cria a variável do Artist com o id informado, e faz eager loading de Album
    def set_music
      @music = Music.includes(:albums, :genre).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def music_params
      params.fetch(:music, {}).permit(:title, :duration, :genre_id)
    end
end
