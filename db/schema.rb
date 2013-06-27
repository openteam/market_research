# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130626072032) do

  create_table "configuration_parameters", :force => true do |t|
    t.integer  "configuration_id"
    t.string   "title"
    t.string   "kind"
    t.float    "weight"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.float    "min_value"
    t.float    "max_value"
  end

  add_index "configuration_parameters", ["configuration_id"], :name => "index_configuration_parameters_on_configuration_id"

  create_table "configurations", :force => true do |t|
    t.integer  "mine_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "configurations", ["mine_id"], :name => "index_configurations_on_mine_id"

  create_table "item_segments", :force => true do |t|
    t.integer  "item_id"
    t.integer  "segment_id"
    t.float    "distance"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "item_segments", ["item_id"], :name => "index_item_segments_on_item_id"
  add_index "item_segments", ["segment_id"], :name => "index_item_segments_on_segment_id"

  create_table "items", :force => true do |t|
    t.text     "data"
    t.integer  "mine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mines", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "segment_parameters", :force => true do |t|
    t.integer  "segment_id"
    t.integer  "configuration_parameter_id"
    t.string   "value"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "segment_parameters", ["configuration_parameter_id"], :name => "index_segment_parameters_on_configuration_parameter_id"
  add_index "segment_parameters", ["segment_id"], :name => "index_segment_parameters_on_segment_id"

  create_table "segments", :force => true do |t|
    t.integer  "configuration_id"
    t.string   "title"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "segments", ["configuration_id"], :name => "index_segments_on_configuration_id"

end
