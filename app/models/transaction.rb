class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :gift
  belongs_to :order

  before_destroy :restore_availability_on_destroy

  validate :gift_has_enough_quantity, on: [:create, :update]

  def self.update_availability_and_set_transaction_price(gift, transaction)
    price = transaction.quantity * gift.price
    availability = gift.availability - transaction.quantity
    gift.update(availability: availability)
    transaction.update(price: price)
  end

  def gift_has_enough_quantity
     @gift = Gift.find(gift_id)
     @gift.has_enough_availability?(quantity)
  end

  def has_order?
    ! self.order.nil?
  end

  def restore_availability_on_destroy
    if ! (has_order and self.order.validated?)
      self.gift.update(availability: self.gift.availability+quantity) if ! quantity.nil?
    end
  end
end
