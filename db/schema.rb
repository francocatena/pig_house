# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110204212631) do

  create_table "deliveries", :force => true do |t|
    t.date     "date",                        :null => false
    t.integer  "born",         :default => 0
    t.integer  "live",         :default => 0
    t.integer  "dead",         :default => 0
    t.integer  "mummified",    :default => 0
    t.integer  "adopted",      :default => 0
    t.integer  "low",          :default => 0
    t.integer  "pig_id"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deliveries", ["pig_id"], :name => "index_deliveries_on_pig_id"

  create_table "pigs", :force => true do |t|
    t.string   "tag",                         :null => false
    t.date     "birth"
    t.string   "genetics"
    t.string   "group"
    t.string   "location"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pigs", ["tag"], :name => "index_pigs_on_tag", :unique => true

  create_table "services", :force => true do |t|
    t.date     "date",                        :null => false
    t.string   "stallion"
    t.integer  "pig_id"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["pig_id"], :name => "index_services_on_pig_id"

  create_table "weanings", :force => true do |t|
    t.date     "date",                                                        :null => false
    t.integer  "weaned",                                       :default => 0
    t.integer  "nursed_weaned",                                :default => 0
    t.integer  "age",                                          :default => 0
    t.decimal  "average_weight", :precision => 4, :scale => 2,                :null => false
    t.integer  "pig_id"
    t.integer  "lock_version",                                 :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weanings", ["pig_id"], :name => "index_weanings_on_pig_id"

end
