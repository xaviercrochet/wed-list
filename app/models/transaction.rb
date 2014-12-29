class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :gift

  before_destroy :restore_availability_on_destroy

  validate :gift_has_enough_quantity, on: [:create, :update]

  def self.update_availability_and_set_transaction_price(gift, transaction)
    price = transaction.quantity * gift.price
    p "availability : "+gift.availability.to_s
    p "quantity : " +transaction.quantity.to_s
    availability = gift.availability - transaction.quantity
    p "coucou" + availability.to_s
    gift.update(availability: availability)
    transaction.update(price: price)
  end

  def gift_has_enough_quantity
     @gift = Gift.find(gift_id)
     @gift.has_enough_quantity?(quantity)
  end

  def restore_availability_on_destroy
    @gift.update(availability: availability+quantity)
  end
end
