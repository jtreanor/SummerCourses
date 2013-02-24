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

ActiveRecord::Schema.define(:version => 0) do

  create_table "administrators", :force => true do |t|
    t.string "forename", :limit => 35,                     :null => false
    t.string "surname",  :limit => 35,                     :null => false
    t.string "email",                                      :null => false
    t.string "password", :limit => 60
    t.binary "isSuper",  :limit => 1,  :default => "b'0'", :null => false
  end

  add_index "administrators", ["id"], :name => "adminID_UNIQUE", :unique => true

  create_table "categories", :force => true do |t|
    t.string "categoryName", :limit => 45, :null => false
  end

  create_table "countries", :primary_key => "countryCode", :force => true do |t|
    t.string "countryName", :limit => 45, :null => false
  end

  create_table "course_media", :id => false, :force => true do |t|
    t.integer "courseID", :null => false
    t.integer "mediaID",  :null => false
  end

  add_index "course_media", ["courseID"], :name => "courseID_idx"
  add_index "course_media", ["mediaID"], :name => "mediaID_idx"

  create_table "courses", :force => true do |t|
    t.string  "title",            :limit => 100,                                               :null => false
    t.text    "description",                                                                   :null => false
    t.text    "briefDescription", :limit => 255,                                               :null => false
    t.integer "teacherID",                                                                     :null => false
    t.integer "numberOfPlaces",                                                                :null => false
    t.decimal "price",                           :precision => 10, :scale => 2,                :null => false
    t.decimal "deposit",                         :precision => 10, :scale => 2,                :null => false
    t.integer "categoryID",                                                                    :null => false
    t.integer "hits",                                                           :default => 0, :null => false
  end

  add_index "courses", ["categoryID"], :name => "categoryID_idx"
  add_index "courses", ["teacherID"], :name => "teacherID_idx"

  create_table "enrollments", :force => true do |t|
    t.integer "studentID",                                    :null => false
    t.integer "courseID",                                     :null => false
    t.binary  "isCancelled", :limit => 1, :default => "b'0'", :null => false
  end

  add_index "enrollments", ["courseID"], :name => "courseID_idx"
  add_index "enrollments", ["studentID"], :name => "studentID_idx"

  create_table "locations", :force => true do |t|
    t.string "title",     :limit => 45, :null => false
    t.float  "longitude",               :null => false
    t.float  "latitude",                :null => false
  end

  create_table "media", :force => true do |t|
    t.string "url",         :limit => 45, :null => false
    t.string "extension",   :limit => 45, :null => false
    t.string "description", :limit => 45, :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "threadID",    :limit => 80,                      :null => false
    t.datetime "timestamp",                                      :null => false
    t.text     "subject",     :limit => 255,                     :null => false
    t.binary   "isResponse",  :limit => 1,   :default => "b'0'", :null => false
    t.text     "messageText",                                    :null => false
  end

  add_index "messages", ["threadID"], :name => "threadID_idx"

  create_table "payments", :force => true do |t|
    t.integer "enrollmentID", :null => false
  end

  add_index "payments", ["enrollmentID"], :name => "enrollmentID_idx"

  create_table "refunds", :id => false, :force => true do |t|
    t.string "refundTransactionID",   :limit => 45, :null => false
    t.string "originalTransactionID", :limit => 45, :null => false
  end

  add_index "refunds", ["originalTransactionID"], :name => "transactionID_idx1"
  add_index "refunds", ["refundTransactionID"], :name => "transactionID_idx"

  create_table "sexes", :force => true do |t|
    t.string "sexName", :limit => 45, :null => false
  end

  create_table "students", :force => true do |t|
    t.string  "forename",    :limit => 35, :null => false
    t.string  "surname",     :limit => 35, :null => false
    t.string  "email",                     :null => false
    t.string  "countryCode", :limit => 2,  :null => false
    t.integer "sexID",       :limit => 1,  :null => false
    t.string  "password",    :limit => 60, :null => false
    t.integer "yearOfBirth",               :null => false
  end

  add_index "students", ["countryCode"], :name => "countryCode_idx"
  add_index "students", ["sexID"], :name => "sexID_idx"

  create_table "teachers", :force => true do |t|
    t.string "photoUrl"
    t.binary "isActive",    :limit => 1,  :default => "b'1'", :null => false
    t.text   "description",                                   :null => false
    t.string "forename",    :limit => 45,                     :null => false
    t.string "surname",     :limit => 45,                     :null => false
    t.string "email",       :limit => 45,                     :null => false
    t.string "password",    :limit => 60,                     :null => false
  end

  add_index "teachers", ["id"], :name => "teacherID_UNIQUE", :unique => true

  create_table "threads", :force => true do |t|
    t.string "userEmail", :null => false
  end

  create_table "time_table_items", :force => true do |t|
    t.integer  "courseID",                 :null => false
    t.integer  "locationID",               :null => false
    t.datetime "startTime",                :null => false
    t.datetime "endTime",                  :null => false
    t.string   "room",       :limit => 45, :null => false
  end

  add_index "time_table_items", ["courseID"], :name => "courseID_idx"
  add_index "time_table_items", ["locationID"], :name => "locationID_idx"

  create_table "transactions", :force => true do |t|
    t.decimal  "amount",    :precision => 10, :scale => 2, :null => false
    t.datetime "timestamp",                                :null => false
  end

  add_index "transactions", ["id"], :name => "transactionID_UNIQUE", :unique => true

end
