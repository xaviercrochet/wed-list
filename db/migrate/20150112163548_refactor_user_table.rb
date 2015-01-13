class RefactorUserTable < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string, index: true
    add_column :users, :coming, :boolean, default: false
  end
end
