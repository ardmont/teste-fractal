class Api::V1::AlbumsController < ApplicationController
  before_action :set_api_v1_album, only: [:show, :update, :destroy]

  # GET /api/v1/albums
  def index
    @api_v1_albums = Album.all

    render json: @api_v1_albums
  end

  # GET /api/v1/albums/1
  def show
    render json: @api_v1_album
  end

  # POST /api/v1/albums
  def create
    @api_v1_album = Album.new(api_v1_album_params)

    if @api_v1_album.save
      render json: @api_v1_album, status: :created
    else
      render json: @api_v1_album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/albums/1
  def update
    if @api_v1_album.update(api_v1_album_params)
      render json: @api_v1_album
    else
      render json: @api_v1_album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/albums/1
  def destroy
    @api_v1_album.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_album
      @api_v1_album = Album.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_album_params
      params.fetch(:album, {}).permit(:title, :genre, :artist)
    end
end
