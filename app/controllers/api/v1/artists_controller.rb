class Api::V1::ArtistsController < ApplicationController
  before_action :set_api_v1_artist, only: [:show, :update, :destroy]

  # GET /api/v1/artists
  def index
    @api_v1_artists = Artist.paginate(page: params[:page], per_page: 30)

    render json: @api_v1_artists
  end

  # GET /api/v1/artists/:id
  def show
    render json: @api_v1_artist
  end

  # POST /api/v1/artists
  def create
    @api_v1_artist = Artist.new(api_v1_artist_params)

    if @api_v1_artist.save
      render json: @api_v1_artist, status: :created
    else
      render json: @api_v1_artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/artists/:id
  def update
    if @api_v1_artist.update(api_v1_artist_params)
      render json: @api_v1_artist
    else
      render json: @api_v1_artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/artists/:id
  def destroy
    @api_v1_artist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_artist
      @api_v1_artist = Artist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_artist_params
      params.fetch(:artist, {}).permit(:name, :genre)
    end
end
