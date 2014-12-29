class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.boolean :validated
      t.boolean :paid
      t.integer :communication
      t.integer :price

      t.timestamps
    end
  end
end
