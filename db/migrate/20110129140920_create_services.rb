class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.date :date, :null => false
      t.string :stallion
      t.references :pig
      t.integer :lock_version, :default => 0

      t.timestamps
    end

    add_index :services, :pig_id
  end

  def self.down
    remove_index :services, :column => :pig_id

    drop_table :services
  end
end