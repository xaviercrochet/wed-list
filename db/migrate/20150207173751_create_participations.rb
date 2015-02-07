class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :user, index: true
      t.integer :adults, default: 1
      t.integer :kids, default: 0

      t.timestamps
    end
  end
end
