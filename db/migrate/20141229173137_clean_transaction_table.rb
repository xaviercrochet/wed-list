class CleanTransactionTable < ActiveRecord::Migration
  def change
    remove_column :transactions, :communication, :integer
    remove_column :transactions, :status, :boolean
    add_reference :transactions, :order, index: true

  end
end
