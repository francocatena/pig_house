class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.date :date, :null => false
      t.integer :born, :default => 0
      t.integer :live, :default => 0
      t.integer :dead, :default => 0
      t.integer :mummified, :default => 0
      t.integer :adopted, :default => 0
      t.integer :low, :default => 0
      t.references :pig
      t.integer :lock_version, :default => 0

      t.timestamps
    end

    add_index :deliveries, :pig_id
  end

  def self.down
    remove_index :deliveries, :column => :pig_id

    drop_table :deliveries
  end
end