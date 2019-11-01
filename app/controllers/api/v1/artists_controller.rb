class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]

  # GET /api/v1/artists
  api :GET, '/api/v1/artists', 'lista todos os artistas'
  param :name, String, desc: 'name do artista'
  param :genre_id, String, desc: 'id do gênero do artista'
  def index
    # Busca todos os artistas, com paginação de 30 elementos por página e faz eager loading com Albums
    artists = Artist.includes(:albums, :genre).where(artist_params).paginate(page: params[:page], per_page: 30)

    render json: artists
  end

  # GET /api/v1/artists/:id
  api :GET, '/api/v1/artists/:id', 'lista um artista específico'
  param :id, :number, desc: 'id do artista', required: true
  def show
    render json: @artist
  end

  # POST /api/v1/artists
  api :POST, '/api/v1/artists', 'cria um artista'
  param :name, String, desc: 'nome do artista', required: true
  param :genre_id, Numeric, desc: 'id do gênero do artista', required: true
  def create
    # Cria um novo artista e o associa ao genênero informado
    @artist = Artist.new(artist_params)

    if @artist.save
      render json: @artist, status: :created
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/artists/:id
  api :PUT, '/api/v1/artists/:id', 'atualiza um artista'
  param :id, :number, desc: 'id do artista', required: true
  param :name, String, desc: 'nome do artista'
  param :genre_id, Numeric, desc: 'id do gênero do artista'
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/artists/:id
  api :DEL, '/api/v1/artists/:id', 'remove um artista'
  param :id, :number, desc: 'id do artista', required: true
  def destroy
    @artist.destroy
  end

  private
    # Procura e cria a variável do Artist com o id informado, e faz eager loading de Album
    def set_artist
      @artist = Artist.includes(:albums, :genre).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artist_params
      params.permit(:name, :genre_id)
    end
end
