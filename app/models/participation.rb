class Participation < ActiveRecord::Base
  belongs_to :user

  validate :adults_or_kids_must_be_strictly_positive
  validate :adults_must_be_positive
  validate :kids_must_be_positive

  def adults_or_kids_must_be_strictly_positive
    if ! (adults > 0 or kids > 0)
      errors.add(:adults, "Au moins une personne doit être présente")
      errors.add(:kids, "Au moins une personne doit être présente")
    end
  end

  def adults_must_be_positive
    if adults < 0
      errors.add(:adults, "Doit être >= 0")
    end
  end

  def kids_must_be_positive
    if kids < 0
      errors.add(:kids, "Doit être >= 0")
    end
  end
end
