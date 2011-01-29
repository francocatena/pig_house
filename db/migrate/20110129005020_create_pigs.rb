class CreatePigs < ActiveRecord::Migration
  def self.up
    create_table :pigs do |t|
      t.string :tag, :null => false
      t.date :birth
      t.string :genetics
      t.string :group
      t.string :location
      t.integer :lock_version, :default => 0

      t.timestamps
    end

    add_index :pigs, :tag, :unique => true
  end

  def self.down
    remove_index :pigs, :column => :tag

    drop_table :pigs
  end
end