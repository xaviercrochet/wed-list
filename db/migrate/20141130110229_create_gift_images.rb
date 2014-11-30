class CreateGiftImages < ActiveRecord::Migration
  def change
    create_table :gift_images do |t|
      t.integer :gift_id

      t.timestamps
    end
  end
end
