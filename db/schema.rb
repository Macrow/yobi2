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

ActiveRecord::Schema.define(:version => 20120108144227) do

  create_table "article_images", :force => true do |t|
    t.string   "image"
    t.integer  "article_id"
    t.boolean  "is_major",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_images", ["article_id"], :name => "index_article_images_on_article_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["url"], :name => "index_articles_on_url", :unique => true

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "position"
    t.string   "ancestry"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["url"], :name => "index_categories_on_url", :unique => true

  create_table "category_images", :force => true do |t|
    t.string   "image"
    t.integer  "category_id"
    t.boolean  "is_major",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_images", ["category_id"], :name => "index_category_images_on_category_id"

  create_table "plists", :force => true do |t|
    t.string "name"
  end

  add_index "plists", ["name"], :name => "index_plists_on_name", :unique => true

  create_table "product_images", :force => true do |t|
    t.string   "image"
    t.integer  "product_id"
    t.boolean  "is_major",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_images", ["product_id"], :name => "index_product_images_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "sn"
    t.decimal  "price_yobi",   :precision => 10, :scale => 0
    t.decimal  "price_retail", :precision => 10, :scale => 0
    t.boolean  "is_elite"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["url"], :name => "index_products_on_url", :unique => true

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["product_id"], :name => "index_properties_on_product_id"

  create_table "slides", :force => true do |t|
    t.string   "image"
    t.boolean  "is_hide",    :default => false
    t.string   "url"
    t.string   "title"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "is_admin",                              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
