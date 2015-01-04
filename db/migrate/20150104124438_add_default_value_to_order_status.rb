class AddDefaultValueToOrderStatus < ActiveRecord::Migration
  def up
    change_column :orders, :validated, :boolean, default: false
    change_column :orders, :paid, :boolean, default: false
  end

  def down
    change_column :orders, :validated, default: nil
    change_column :orders, :paid, :boolean, default: nil
  end
end
