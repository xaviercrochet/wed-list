class Order < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :destroy
  after_create :compute_price, :generate_communication
  scope :paid, -> {where(paid: true) }
  scope :unpaid, -> { where(paid: false)}
  scope :validated, -> { where(validated: true)}
  scope :unvalidated, -> { where(validated: false)}

  def compute_price
    price = 0
    self.transactions.each do |t|
      price += t.price
    end
    self.price = price
    self.save
  end

  def generate_communication
    hashids = Hashids.new("Coucou", 10)
    self.communication = hashids.encode(self.id)
    self.save
  end

  def self.decode_communication(hash)
    hashids = Hashids.new("Coucou", 10)
    return hashids.decode(hash)
  end

  def self.retrieve_order_from_hash(hash)
    return Order.find(Order.decode_communication(hash)).first
  end

  def pay
    self.paid = true
    self.save
  end

  def validate
    self.validated = true
    self.paid = true
    self.save
  end

  def verify_amount(amount)
    return self.price == amount.to_i
  end
end
