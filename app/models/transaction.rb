class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :gift
  belongs_to :order
  scope :ordered, -> { where.not(order_id: nil) }
  scope :unordered, -> { where(order_id: nil) }

  before_destroy :restore_availability_on_destroy

  validate :gift_has_enough_quantity, on: [:create, :update]


  def gift_has_enough_quantity
     @gift = Gift.find(gift_id)
     @gift.has_enough_availability?(quantity)
  end

  def has_order?
    ! self.order.nil?
  end

  def update_transaction_quantity_and_price(quantity)
    new_quantity = self.quantity + quantity.to_i
    self.quantity = new_quantity
    self.price = new_quantity * self.gift.price
    self.save
  end

  def set_price
    self.price = self.quantity * self.gift.price
    self.save
  end

  def self.look_for_same_transaction(gift, user)
    results = Transaction.where(gift_id: gift.id, user_id: user.id, order_id: nil)
    return results.first if ! results.empty?
  end




  def restore_availability_on_destroy
    if ! self.gift.nil? and ! (has_order? and self.order.validated?)
      self.gift.update(availability: self.gift.availability+quantity) if ! quantity.nil?
    end
  end
end
