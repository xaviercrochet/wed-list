class UsersController < ApplicationController

  before_filter :authenticate_user!

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(user_params)
    if @user.errors.any?
      render action: :new
    else
      redirect_to @user
    end
  end

  def rsvp
    @user = current_user
  end

  def update_rsvp
    @user = current_user
    @user.update_rsvp!
    redirect_to rsvp_user_path(@user)
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if ! @user.errors.any?
      flash[:success] = "Votre profil a été mis à jour."
    end
    sign_in @user, :bypass => true
    render action: :edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone)
  end
end
