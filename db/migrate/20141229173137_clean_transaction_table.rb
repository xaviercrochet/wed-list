class CleanTransactionTable < ActiveRecord::Migration
  def change
    remove_column :transactions, :communication
    remove_column :transactions, :status
    add_reference :transactions, :order, index: true

  end
end
