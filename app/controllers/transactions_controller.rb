class TransactionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @gift = Gift.new
  end

  def index
    @transactions = current_user.transactions
  end

  def create
    gift = Gift.find(params[:gift_id])
    transaction = Transaction.look_for_same_transaction(gift, current_user)
    #if don't exist, create it!
    if transaction.nil?
      transaction = gift.transactions.create(user_id: current_user.id, quantity: params[:quantity])
      transaction.set_price()
    else
      transaction.update_transaction_quantity_and_price(params[:quantity])
    end
    #update gift availability
    gift.update_availability_by(params[:quantity])
    redirect_to user_transactions_path(current_user)
  end

  def destroy
    if ! @transaction.has_order?
      @transaction.destroy
      redirect_to user_transactions_path(current_user)
    end
  end
end
