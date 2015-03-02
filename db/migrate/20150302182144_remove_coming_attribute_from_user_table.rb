class RemoveComingAttributeFromUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :coming, :boolean
  end
end
