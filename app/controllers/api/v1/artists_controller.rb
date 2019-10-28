class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]

  # GET /api/v1/artists
  def index
    # Busca todos os artistas, com paginação de 30 elementos por página e faz eager loading com Albums
    artists = Artist.includes(:albums).paginate(page: params[:page], per_page: 30)

    # Este array armazenará os artistas e será utilizado como resposta
    response = []

    artists.each do |artist|
      # Serializa o objeto artist para posteriormente adicionar os álbums do artista
      artist_as_json = artist.as_json

      # Adiciona os álbums do artista ao json que será enviado
      artist_as_json["albums"] = artist.albums

      response << artist_as_json
    end

    render json: response
  end

  # GET /api/v1/artists/:id
  def show
    render json: @artist
  end

  # POST /api/v1/artists
  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      render json: @artist, status: :created
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/artists/:id
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/artists/:id
  def destroy
    @artist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artist_params
      params.fetch(:artist, {}).permit(:name, :genre)
    end
end
