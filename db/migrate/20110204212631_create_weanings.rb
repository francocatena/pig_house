class CreateWeanings < ActiveRecord::Migration
  def self.up
    create_table :weanings do |t|
      t.date :date, :null => false
      t.integer :weaned, :default => 0
      t.integer :nursed_weaned, :default => 0
      t.integer :age, :default => 0
      t.decimal :average_weight, :null => false, :precision => 4, :scale => 2
      t.references :pig
      t.integer :lock_version, :default => 0

      t.timestamps
    end

    add_index :weanings, :pig_id
  end

  def self.down
    remove_index :weanings, :column => :pig_id

    drop_table :weanings
  end
end