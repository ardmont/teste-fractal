class Api::V1::AlbumsController < ApplicationController
  before_action :set_artist, only: :create
  before_action :set_musics, only: [:create, :update]
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /api/v1/albums
  def index
    # Busca todos os álbums, com paginação de 30 elementos por página e faz eager loading com Artist e Music
    albums = Album.includes(:artist, :musics).paginate(page: params[:page], per_page: 30)

    # Este array armazenará os álbums e será utilizado como resposta
    response = []

    albums.each do |album|
      # Serializa o objeto album para posteriormente adicionar artist e musics
      album_as_json = album.as_json

      # Adiciona o artista do álbum ao json que será enviado
      album_as_json["artist"] = album.artist

      # Adiciona as musicas do álbum ao json que será enviado
      album_as_json["musics"] = album.musics.as_json

      response << album_as_json
    end

    render json: response
  end

  # GET /api/v1/albums/:id
  def show
    # Serializa o objeto album para posteriormente adicionar artist e musics
    @album_as_json = @album.as_json

    # Adiciona o artista do álbum ao json que será enviado
    @album_as_json["artist"] = @album.artist

    # Adiciona as musicas do álbum ao json que será enviado
    @album_as_json["musics"] = @album.musics.as_json

    render json: @album_as_json
  end

  # POST /api/v1/albums
  def create
    # Cria um novo Album e passa o objeto do artist encontrado como valor para o campo artist
    @album = Album.new(album_params.merge({artist: @artist}))

    # Verifica se existem musicas a serem adicionadas, e as vincula ao álbum
    if(defined?(@musics)) then @album.musics << @musics end

    if @album.save
      render json: @album, status: :created
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/albums/:id
  def update
    # Verifica se existem musicas a serem adicionadas, e as vincula ao álbum
    if(defined?(@musics)) then @album.musics << @musics end

    # Atualiza o álbum
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/albums/:id
  def destroy
    @album.destroy
  end

  private
    # Procura e cria a variável do Album com o id informado, com eager loading de Artist e Music
    def set_album
      @album = Album.includes(:artist, :musics).find(params[:id])
    end

    # Procura e cria a variável do Artist com o id informado pelo parâmetro artist_id
    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    # Verifica se existem musicas apra serem adicionadas, e inicia a variável musics
    def set_musics
      if(params.has_key?(:add_musics)) then
        @musics = Music.where(id: params[:add_musics])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.fetch(:album, {}).permit(:title, :genre, :artist_id)
    end
end
