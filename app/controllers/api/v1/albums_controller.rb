class Api::V1::AlbumsController < ApplicationController
  before_action :set_artist, only: [:create, :update]
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /api/v1/albums
  def index
    @albums = Album.all

    render json: @albums
  end

  # GET /api/v1/albums/1
  def show
    render json: @album
  end

  # POST /api/v1/albums
  def create
    # Cria um novo Album e passa o objeto do artist encontrado como valor para o campo artist
    @album = Album.new(album_params.merge({artist: @artist}))

    if @album.save
      render json: @album, status: :created
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/albums/1
  def update
    if @album.update(album_params.merge({artist: @artist}))
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/albums/1
  def destroy
    @album.destroy
  end

  private
    # Procura e cria a variável do Album com o id informado
    def set_album
      @album = Album.find(params[:id])
    end

    # Procura e cria a variável do Artist com o id informado pelo parâmetro artist_id
    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.fetch(:album, {}).permit(:title, :genre, :artist_id)
    end
end
