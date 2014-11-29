class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :title
      t.boolean :status, default: true
      t.integer :price
      t.integer :availability

      t.timestamps
    end
  end
end
