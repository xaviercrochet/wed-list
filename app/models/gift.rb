class Gift < ActiveRecord::Base
  validates :title, presence: true
  validates :price, presence: true
  validates :availability, presence: true
  validate :price_must_be_positive, :availability_must_be_strictly_positive

  has_many :gift_images, dependent: :destroy
  accepts_nested_attributes_for :gift_images, allow_destroy: true


  def price_must_be_positive
    if ! price.nil? && price < 0
      errors.add(:price, "doit être positif (>=0)")
    end
  end

  def availability_must_be_strictly_positive
    if ! availability.nil? && availability <= 0
      errors.add(:availability, "doit être strictement positif (>0)")
    end
  end
end
