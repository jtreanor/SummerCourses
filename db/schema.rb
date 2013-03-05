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

ActiveRecord::Schema.define(:version => 20130228095757) do

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
    t.string   "email",                                :default => "", :null => false
    t.string   "forename",               :limit => 35,                 :null => false
    t.string   "surname",                :limit => 35,                 :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "categories", :force => true do |t|
    t.string "category_name", :limit => 45, :null => false
  end

  create_table "countries", :id => false, :force => true do |t|
    t.string "country_id",   :limit => 2
    t.string "country_name", :limit => 45, :null => false
  end

  add_index "countries", ["country_id"], :name => "country_id_idx"

  create_table "course_media", :id => false, :force => true do |t|
    t.integer "course_id", :null => false
    t.integer "media_id",  :null => false
  end

  add_index "course_media", ["course_id"], :name => "course_id_idx"
  add_index "course_media", ["media_id"], :name => "mediaID_idx"

  create_table "courses", :force => true do |t|
    t.string  "title",             :limit => 100,                                               :null => false
    t.text    "description",                                                                    :null => false
    t.text    "brief_description", :limit => 255,                                               :null => false
    t.integer "teacher_id",                                                                     :null => false
    t.integer "number_of_places",                                                               :null => false
    t.decimal "price",                            :precision => 10, :scale => 2,                :null => false
    t.decimal "deposit",                          :precision => 10, :scale => 2,                :null => false
    t.integer "category_id",                                                                    :null => false
    t.integer "hits",                                                            :default => 0, :null => false
    t.datetime "refund_enrollments_before",                                                     :null => false
  end

  add_index "courses", ["category_id"], :name => "category_id_idx"
  add_index "courses", ["teacher_id"], :name => "teacher_id_idx"
  add_foreign_key "courses", "categories", :name => "courses_category_id_fk"

  create_table "enrollments", :force => true do |t|
    t.integer "student_id",                      :null => false
    t.integer "course_id",                       :null => false
    t.boolean "is_cancelled", :default => false, :null => false
  end

  add_index "enrollments", ["course_id"], :name => "course_id_idx"
  add_index "enrollments", ["student_id"], :name => "student_id_idx"
  add_foreign_key "enrollments", "courses", :name => "enrollments_course_id_fk"
  #add_foreign_key "enrollments", "students", :name => "enrollments_student_id_fk", :primary_key => "id", :sender_id => "student_id"

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

  create_table "message_threads", :force => true do |t|
    t.string   "user_email", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "message_thread_id", :limit => 80,                     :null => false
    t.text     "subject",           :limit => 255,                    :null => false
    t.boolean  "is_response",                      :default => false, :null => false
    t.text     "content",                                             :null => false
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "messages", ["message_thread_id"], :name => "message_thread_id_idx"
  #add_foreign_key "messages", "message_threads", :name => "messages_message_thread_id_fk"

  create_table "payments", :id => false, :force => true do |t|
    t.string  "transaction_id",    :limit => 10, :null => false
    t.integer "enrollment_id", :null => false
  end

  add_index "payments", ["enrollment_id"], :name => "payments_enrollment_id_idx"
  add_index "payments", ["transaction_id"], :name => "payments_transaction_id_idx"
  add_foreign_key "payments", "enrollments", :name => "payments_enrollment_id_fk"
  #add_foreign_key "payments", "transactions", :name => "payments_transaction_id_fk"

  create_table "refunds", :id => false, :force => true do |t|
    t.string "refundTransactionID",   :limit => 45, :null => false
    t.string "originalTransactionID", :limit => 45, :null => false
  end

  add_index "refunds", ["originalTransactionID"], :name => "transactionID_idx1"
  add_index "refunds", ["refundTransactionID"], :name => "transactionID_idx"

  create_table "sexes", :id => false, :force => true do |t|
    t.integer "sex_id",                 :limit => 1,                  :null => false
    t.string  "sex_name", :limit => 45, :null => false
  end

  add_index "sexes", ["sex_id"], :name => "sex_id_idx"

  create_table "students", :force => true do |t|
    t.string   "forename",               :limit => 35,                 :null => false
    t.string   "surname",                :limit => 35,                 :null => false
    t.string   "country_id",             :limit => 2,                  :null => false
    t.integer  "sex_id",                 :limit => 1,                  :null => false
    t.integer  "year_of_birth",                                        :null => false
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "students", ["country_id"], :name => "country_id_idx"
  add_index "students", ["email"], :name => "index_students_on_email", :unique => true
  add_index "students", ["reset_password_token"], :name => "index_students_on_reset_password_token", :unique => true
  add_index "students", ["sex_id"], :name => "sex_id_idx"
  add_foreign_key "students", "countries", :name => "students_country_id_fk", :primary_key => "country_id"
  add_foreign_key "students", "sexes", :name => "students_sex_id_fk", :primary_key => "sex_id"

  create_table "teachers", :force => true do |t|
    t.string  "photoUrl"
    t.boolean "isActive",                  :default => true, :null => false
    t.text    "description",                                 :null => false
    t.string  "forename",    :limit => 45,                   :null => false
    t.string  "surname",     :limit => 45,                   :null => false
    t.string  "email",       :limit => 45,                   :null => false
    t.string  "password",    :limit => 60,                   :null => false
  end

  add_index "teachers", ["id"], :name => "teacherID_UNIQUE", :unique => true

  create_table "time_table_items", :force => true do |t|
    t.integer  "courseID",                 :null => false
    t.integer  "locationID",               :null => false
    t.datetime "startTime",                :null => false
    t.datetime "endTime",                  :null => false
    t.string   "room",       :limit => 45, :null => false
  end

  add_index "time_table_items", ["courseID"], :name => "courseID_idx"
  add_index "time_table_items", ["locationID"], :name => "locationID_idx"

=begin
  create_table "transactions", :id => false, :force => true do |t|
    t.string  "id",    :limit => 10,           :null => false
    t.decimal  "amount",    :precision => 10, :scale => 2, :null => false
    t.datetime "timestamp",                                :null => false
  end

  add_index "transactions", ["id"], :name => "transaction_id_UNIQUE", :unique => true
=end
end