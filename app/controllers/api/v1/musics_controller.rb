class Api::V1::MusicsController < ApplicationController
  before_action :set_music, only: [:show, :update, :destroy]

  # GET /api/v1/musics
  api :GET, '/api/v1/musics', 'lista todas as músicas'
  param :title, String, desc: 'título da música'
  param :genre_id, String, desc: 'id do gênero do música'
  def index
    # Busca todos as musicas, com paginação de 30 elementos por página e faz eager loading com Albums
    musics = Music.includes(:albums, :genre).where(music_params).paginate(page: params[:page], per_page: 30)
    
    render json: musics
  end

  # GET /api/v1/musics/:id
  api :GET, '/api/v1/musics/:id', 'lista uma música específica'
  param :id, :number, desc: 'id da musica', required: true
  def show    
    render json: @music
  end

  # POST /api/v1/musics
  api :POST, '/api/v1/musics', 'Cria uma música'
  param :title, String, desc: 'título da música', required: true
  param :genre_id, Numeric, desc: 'id do gênero da música', required: true 
  def create
    @music = Music.new(music_params)

    if @music.save
      render json: @music, status: :created
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/musics/:id
  api :PUT, '/api/v1/musics/:id', 'atualiza uma música'
  param :id, :number, desc: 'id da música', required: true
  param :title, String, desc: 'título da música'
  param :genre_id, Numeric, desc: 'id do gênero da música'
  def update
    if @music.update(music_params)
      render json: @music
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/musics/:id
  api :DEL, '/api/v1/musics/:id', 'remove uma música'
  param :id, :number, desc: 'id da música', required: true
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
      params.permit(:title, :duration, :genre_id)
    end
end
