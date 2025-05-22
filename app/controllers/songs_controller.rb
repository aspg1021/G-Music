class SongsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_song, only: %i[ show edit update destroy ]

  # GET /songs or /songs.json
  def index
    @songs = Song.all
  end

  # ログイン中ユーザーの楽曲一覧
  def user_index
    @songs = current_user.songs
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs or /songs.json
  def create
    @song = current_user.songs.new(song_params)

    if @song.save
      redirect_to songs_path, notice: '楽曲を登録しました。'
    else
      render :new
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to songs_path, notice: "楽曲を更新しました。" }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song = current_user.songs.find_by(id: params[:id])
    if @song
      @song.destroy
      redirect_to request.referer || root_path, notice: "楽曲を削除しました。"
    else
      redirect_to songs_path, alert: "権限がないため削除できません。"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
      if action_name.in?(%w[edit update destroy]) && @song.user != current_user
        redirect_to songs_path, alert: "権限がありません"
      end
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :youtube_video_url, :channel_name, :user_id)
    end
end
