class TransactionsController < ApplicationController

  def new

  end

  def create
    @gift = Gift.find(params[:gift_id])
    @transaction = @gift.transactions.create(user_id: current_user.id)
    redirect_to @transaction.gift
  end
end
