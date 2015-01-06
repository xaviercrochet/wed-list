class ModifyCommunicationType < ActiveRecord::Migration
  def change
    change_column :orders, :communication, :string
  end
end
