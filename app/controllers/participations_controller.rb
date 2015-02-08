class ParticipationsController < ApplicationController
  def index
  end

  def edit
    @participation = current_user.participation
  end

  def create
  end

  def destroy
  end

  def new
    @participation = Participation.new
  end
end
