class Api::V1::MusicsController < ApplicationController
  before_action :set_music, only: [:show, :update, :destroy]

  # GET /api/v1/musics
  def index
    # Busca todos as musicas, com paginação de 30 elementos por página e faz eager loading com Albums
    @musics = Music.includes(:albums).paginate(page: params[:page], per_page: 30)

    render json: @musics
  end

  # GET /api/v1/musics/:id
  def show
    render json: @music
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
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def music_params
      params.fetch(:music, {}).permit(:title, :duration, :genre)
    end
end
