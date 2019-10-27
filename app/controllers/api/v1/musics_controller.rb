class Api::V1::MusicsController < ApplicationController
  before_action :set_api_v1_music, only: [:show, :update, :destroy]

  # GET /api/v1/musics
  def index
    @api_v1_musics = Music.all

    render json: @api_v1_musics
  end

  # GET /api/v1/musics/1
  def show
    render json: @api_v1_music
  end

  # POST /api/v1/musics
  def create
    @api_v1_music = Music.new(api_v1_music_params)

    if @api_v1_music.save
      render json: @api_v1_music, status: :created
    else
      render json: @api_v1_music.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/musics/1
  def update
    if @api_v1_music.update(api_v1_music_params)
      render json: @api_v1_music
    else
      render json: @api_v1_music.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/musics/1
  def destroy
    @api_v1_music.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_music
      @api_v1_music = Music.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_music_params
      params.fetch(:music, {}).permit(:title, :duration, :genre)
    end
end
