class GiftImage < ActiveRecord::Base

  belongs_to :gift
  has_attached_file :photo
  
end
