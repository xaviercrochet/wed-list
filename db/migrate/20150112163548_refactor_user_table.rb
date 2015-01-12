class RefactorUserTable < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :coming, :boolean, default: false
  end
end
