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

ActiveRecord::Schema.define(:version => 20121028074215) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cal_events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "parent_id"
    t.integer  "type_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.boolean  "auto_load"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "categories_items", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "category_id"
  end

  add_index "categories_items", ["item_id", "category_id"], :name => "index_categories_items_on_item_id_and_category_id"

  create_table "contacts", :force => true do |t|
    t.integer  "place_id"
    t.string   "tel"
    t.string   "mail"
    t.string   "site"
    t.string   "address"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "item_id"
    t.integer  "place_id"
    t.integer  "category_id"
    t.datetime "date_begin"
    t.datetime "date_end"
    t.boolean  "auto_load"
    t.integer  "room_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["place_id"], :name => "index_events_on_place_id"
  add_index "events", ["room_id"], :name => "index_events_on_room_id"

  create_table "events_items", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "event_id"
  end

  add_index "events_items", ["item_id", "event_id"], :name => "index_events_items_on_item_id_and_event_id"

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "type_id"
    t.integer  "item_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "galleries", ["item_id"], :name => "index_galleries_on_item_id"

  create_table "images", :force => true do |t|
    t.string   "name"
    t.integer  "gallery_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["gallery_id"], :name => "index_images_on_gallery_id"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "full_text"
    t.text     "info"
    t.datetime "date"
    t.integer  "type_id"
    t.boolean  "auto_load"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.text     "desc"
    t.integer  "contact_id"
    t.integer  "item_id"
    t.boolean  "auto_load"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "places", ["category_id"], :name => "index_places_on_category_id"
  add_index "places", ["contact_id"], :name => "index_places_on_contact_id"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.integer  "place_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
