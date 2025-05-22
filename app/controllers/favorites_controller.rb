class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_songs = current_user.favorite_songs.includes(:user)
  end
  
  def create
    @song = Song.find(params[:song_id])
    current_user.favorites.create(song: @song)
    redirect_back fallback_location: songs_path, notice: "お気に入りに登録しました"
  end

  def destroy
    @song = Song.find(params[:song_id])
    favorite = current_user.favorites.find_by(song: @song)
    favorite&.destroy
    redirect_back fallback_location: songs_path, notice: "お気に入りから削除しました"
  end
end
