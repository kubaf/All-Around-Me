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

ActiveRecord::Schema.define(:version => 20130402041208) do

  create_table "choices", :force => true do |t|
    t.integer  "question_id",         :null => false
    t.string   "type"
    t.integer  "choice_number",       :null => false
    t.string   "choice_text"
    t.integer  "choice_range_number"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "session_token"
    t.integer  "admin"
    t.string   "type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "people", ["email"], :name => "index_people_on_email", :unique => true
  add_index "people", ["session_token"], :name => "index_people_on_session_token"

  create_table "questions", :force => true do |t|
    t.string   "type"
    t.text     "question_text",                    :null => false
    t.integer  "question_order",                   :null => false
    t.integer  "min_valid_choices", :default => 1
    t.integer  "max_valid_choices", :default => 1
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "responses", :force => true do |t|
    t.string   "type"
    t.text     "response_text"
    t.integer  "mc_question_choice_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "review_user_response_set_id"
  end

  create_table "review_reviewers", :force => true do |t|
    t.integer  "person_id",    :null => false
    t.integer  "review_id",    :null => false
    t.string   "relationship", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "review_reviewers", ["review_id", "person_id"], :name => "index_review_reviewers_on_review_id_and_person_id", :unique => true

  create_table "review_user_response_sets", :force => true do |t|
    t.integer  "review_id"
    t.integer  "person_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "reviews", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "status_dt"
    t.integer  "duration"
  end

end
