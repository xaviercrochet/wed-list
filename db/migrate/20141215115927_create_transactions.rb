class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :gift_id
      t.integer :quantity
      t.integer :price
      t.boolean :status, default: false
      t.integer :communication

      t.timestamps
    end
  end
end
