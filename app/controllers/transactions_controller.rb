class TransactionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.find(params[:gift_id])
    p params[:quantity]
    @transaction = @gift.transactions.create(user_id: current_user.id, quantity: params[:quantity])
    Transaction.update_availability_and_set_transaction_price(@gift, @transaction)
    redirect_to @transaction.gift
  end
end
