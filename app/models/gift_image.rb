class GiftImage < ActiveRecord::Base

  belongs_to :gift
  has_attached_file :photo, :styles => { small: "32x32", medium: "300x300>"}

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end
