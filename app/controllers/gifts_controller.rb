class GiftsController < ApplicationController
  def index
    @gifts = Gift.all
  end

  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.create(gift_params)
    if @gift.errors.any?
      render action: :new
    else
      redirect_to @gift
    end
  end

  def update
    @gift = Gift.find(params[:id])

    if @gift.update(gift_params)
      redirect_to @gift
    else
      render 'edit'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    redirect_to gifts_path
  end

  def edit
    @gift = Gift.find(params[:id])
  end

  def show
    @gift = Gift.find(params[:id])
  end

  private

    def gift_params
      params.require(:gift).permit(:title, :price, :availability, :gift_images)
    end
end
