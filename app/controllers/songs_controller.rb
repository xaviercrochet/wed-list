class SongsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @song = current_user.songs.new
  end

  def index
    @songs = Song.all
  end

  def create
    @song = Song.create(song_params)
    if @song.errors.any?
      render action: :new
    else
      redirect_to songs_path
    end
  end

private
  def song_params
    params.require(:song).permit(:title, :artist, :url)
  end
end
