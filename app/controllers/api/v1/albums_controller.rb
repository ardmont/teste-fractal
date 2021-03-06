class Api::V1::AlbumsController < ApplicationController
  before_action :set_musics, only: [:create, :update]
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /api/v1/albums
  api :GET, '/api/v1/albums', 'lista todos os álbums'
  param :title, String, desc: 'título do álbum'
  param :genre_id, String, desc: 'id do gênero do álbum'
  param :artist_id, String, desc: 'id do artista do álbum'
  param :s, String, desc: 'Ordenação desejada. ex: s=title+asc'
  def index
    # Busca todos os álbums, com paginação de 30 elementos por página e faz eager loading com Artist e Music
    albums = Album.ransack(params)
    albums.sorts = 'title asc' if albums.sorts.empty?
    albums = albums.result.includes(:artist, :musics, :genre).paginate(page: params[:page], per_page: 30) 

    render json: albums
  end

  # GET /api/v1/albums/:id
  api :GET, '/api/v1/albums/:id', 'lista um álbum específico'
  param :id, :number, desc: 'id do álbum', required: true
  def show
    render json: @album
  end

  # POST /api/v1/albums
  api :POST, '/api/v1/albums', 'Cria um álbum'
  param :title, String, desc: 'título do álbum', required: true
  param :genre_id, Numeric, desc: 'id do gênero do álbum', required: true
  param :artist_id, Numeric, desc: 'id do artista do álbum', required: true
  param :add_musics, Array, desc: 'músicas a serem adicionadas no álbum'
  def create
    # Cria um novo Album e passa o objeto do artist encontrado como valor para o campo artist
    @album = Album.new(album_params)

    # Verifica se existem musicas a serem adicionadas, e as vincula ao álbum
    if(defined?(@musics)) then @album.musics << @musics end

    if @album.save
      render json: @album, status: :created
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/albums/:id
  api :PUT, '/api/v1/albums/:id', 'atualiza um álbum'
  param :id, :number, desc: 'id do álbum', required: true
  param :title, String, desc: 'título do álbum'
  param :genre_id, Numeric, desc: 'id do gênero do álbum'
  param :artist_id, Numeric, desc: 'id do artista do álbum'
  param :add_musics, Array, desc: 'músicas a serem adicionadas no álbum'
  param :remove_musics, Array, desc: 'músicas a serem removidas no álbum'
  def update
    # Verifica se existem musicas a serem adicionadas, e as vincula ao álbum
    if(defined?(@musics)) then @album.musics << @musics end

    # Verifica se existem musicas a serem removidas, e as remove do álbum
    if(params.has_key?(:remove_musics)) then
      musics_to_remove = Music.where(id: params[:remove_musics])
      @album.musics.delete(musics_to_remove)
    end

    # Atualiza o álbum
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/albums/:id
  api :DEL, '/api/v1/albums/:id', 'remove um álbum'
  param :id, :number, desc: 'id da música', required: true
  def destroy
    @album.destroy
  end

  private
    # Procura e cria a variável do Album com o id informado, com eager loading de Artist e Music
    def set_album
      @album = Album.includes(:artist, :musics, :genre).find(params[:id])
    end

    # Verifica se existem musicas apra serem adicionadas, e inicia a variável musics
    def set_musics
      if(params.has_key?(:add_musics)) then
        @musics = Music.where(id: params[:add_musics])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.permit(:title, :genre_id, :artist_id, :favorite)
    end
end
