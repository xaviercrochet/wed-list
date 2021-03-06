class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @order = current_user.orders.new
  end

  def validate
  end

  def pay
    @order = Order.find(params[:order_id])
  end

  def paid
    @order = Order.find(params[:order_id])
    @order.pay
    redirect_to @order
  end

  def destroy
    @user = @order.user
    @order = Order.find(params[:id])
    @order.destroy if ! @order.nil?
    redirect_to user_orders_path(@user)
  end

  def show
    @order = Order.find(params[:id])
  end

  def validates
    @order = Order.find(params[:order_id])
    @order.validate
    flash[:success] = true
    redirect_to validate_orders_path
  end

  def save_validation
    @amount = params[:amount]
    hash = params[:communication]
    @order = Order.retrieve_order_from_hash(hash)
    if @order.nil?
      flash[:success] = false
    elsif ! @order.verify_amount(@amount)
      render 'orders/admin/_amount_not_correct'
      return
    else
      flash[:success] = true
      @order.validate
    end
    redirect_to validate_orders_path
  end

  def create
    @order = current_user.orders.create
    @order.transactions << current_user.transactions.unordered
    @order.compute_price
    @order.generate_communication
    redirect_to @order
  end

  def index
    @orders = current_user.orders
  end
end
