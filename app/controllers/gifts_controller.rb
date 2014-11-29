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
  end

  def destroy
  end

  def show
    @gift = Gift.find(params[:id])

  end

  private

    def gift_params
      params.require(:gift).permit(:title, :price, :availability)
    end
end
