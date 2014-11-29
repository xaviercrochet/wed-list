class GiftsController < ApplicationController
  def index
  end

  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.create(gift_params)
    redirect_to @gift
  end

  def show
  end

  private

    def gift_params
      params.require(:gift).permit(:title, :price, :availability)
    end
end
