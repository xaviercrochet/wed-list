class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :title
      t.boolean :status
      t.true :default
      t.integer :price
      t.availability :availability

      t.timestamps
    end
  end
end
