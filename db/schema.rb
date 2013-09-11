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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130911163012) do

  create_table "feedbacks", force: true do |t|
    t.string   "method_name"
    t.integer  "up"
    t.integer  "down"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["method_name"], name: "index_feedbacks_on_method_name", unique: true, using: :btree

end
