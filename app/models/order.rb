class Order < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :destroy
  after_create :compute_price, :generate_communication

  def compute_price
    price = 0
    self.transactions.each do |t|
      price += t.price
    end
    self.price = price
    self.save
  end

  def generate_communication
    seed = self.id
    while seed <= 9999999999
      seed *= 10
    end
    seed /= 10
    modulo = 10%97
    self.communication = seed.to_s + modulo.to_s
    self.save
  end

end
