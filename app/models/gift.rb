class Gift < ActiveRecord::Base
  validates :title, presence: true
  validates :price, presence: true
  validates :availability, presence: true
  validate :price_must_be_positive, :availability_must_be_strictly_positive


  def price_must_be_positive
    if price < 0
      errors.add(:price, "Le prix doit être positif!")
    end
  end

  def availability_must_be_strictly_positive
    if availability <= 0
      errors.add(:availability, "La disponnibilité du cadeau doit être plus grande que 0!")
    end
  end
end
