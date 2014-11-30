class AddAttachmentPhotoToGiftImages < ActiveRecord::Migration
  def self.up
    change_table :gift_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :gift_images, :photo
  end
end
