class ModifyCommunicationType < ActiveRecord::Migration
  def change
    change_column :orders, :comunication, :string
    rename_column :orders, :comunication, :communication
  end
end
