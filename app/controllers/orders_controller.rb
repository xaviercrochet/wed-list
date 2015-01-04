class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.create
    @order.transactions << current_user.transactions.unordered
    @order.compute_price
    @order.generate_communication
    redirect_to user_transactions_path(current_user)
  end
end
