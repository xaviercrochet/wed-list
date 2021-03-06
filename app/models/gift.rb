class Gift < ActiveRecord::Base
  has_one :gift_image, dependent: :destroy
  has_many :transactions

  validates :title, presence: true
  validates :gift_image, presence: true
  validates :price, presence: true
  validates :availability, presence: true
  validate :price_must_be_positive, :availability_must_be_strictly_positive, on: :create
  validate :availability_must_be_positive, on: :update
  before_destroy :delete_unpaid_transactions

  accepts_nested_attributes_for :gift_image

  def price_must_be_positive
    if ! price.nil? && price < 0
      errors.add(:price, "doit être positif (>=0)")
    end
  end

  def delete_transactions
    self.transactions.each do |t|
      t.destroy if t.unpaid?
    end
  end



  def availability_must_be_positive
    if ! availability.nil? && availability <0
      errors.add(:availability, "doit être positif (>= 0)")
    end
  end

  def availability_must_be_strictly_positive
    if ! availability.nil? && availability <= 0
      errors.add(:availability, "doit être strictement positif (>0)")
    end
  end

  def update_availability_by(quantity)
    new_availability = self.availability - quantity.to_i
    self.availability = new_availability
    self.save
  end

  def available?
    availability > 0
  end

  def has_enough_availability?(quantity)
    availability >= quantity
  end
end
