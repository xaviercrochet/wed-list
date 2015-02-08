class ParticipationsController < ApplicationController
  def index
  end

  def edit
    @participation = current_user.participation
  end

  def create
    @participation = current_user.create_participation(participation_params)
    if ! @participations.errors.any?
      flash[:success] = true
    end
    redirect_to edit_user_participation_path(current_user, @participation)

  end

  def destroy
    current_user.participation.destroy
    redirect_to new_user_participation_path(current_user)
  end

  def update
    @participation = current_user.participation
    @participation.update(participation_params)
    if ! @participation.errors.any?
      flash[:success] = true
    end
    redirect_to edit_user_participation_path(current_user, @participation)
  end

  def new
    @participation = Participation.new
  end
private
  def participation_params
    params.require(:participation).permit(:adults, :kids)
  end
end
