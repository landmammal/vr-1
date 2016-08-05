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

ActiveRecord::Schema.define(version: 20160723020746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "concepts", force: :cascade do |t|
    t.text     "description"
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.string   "privacy"
    t.string   "language"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "course_registrations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "user_role"
    t.boolean  "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "course_topics", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tags"
    t.integer  "instructor_id"
    t.string   "privacy"
    t.string   "language"
    t.string   "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "demos", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.date     "date"
    t.string   "contacted"
    t.string   "completed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "explanations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.string   "title"
    t.string   "video_type"
    t.string   "token"
    t.string   "video_token"
    t.string   "script"
    t.string   "language"
    t.string   "privacy"
    t.string   "position_prior"
    t.integer  "watched"
    t.string   "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "group_registrations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "group_id"
    t.boolean  "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "group_registrations", ["course_id"], name: "index_group_registrations_on_course_id", using: :btree
  add_index "group_registrations", ["group_id"], name: "index_group_registrations_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "instructor_id"
    t.string   "privacy"
    t.string   "language"
    t.string   "website"
    t.string   "tags"
    t.integer  "member_limit"
    t.string   "group_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "lesson_concepts", force: :cascade do |t|
    t.integer  "concept_id"
    t.integer  "lesson_id"
    t.decimal  "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lesson_explanations", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "explanation_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "lesson_models", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lesson_prompts", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "prompt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lesson_rehearsals", force: :cascade do |t|
    t.integer  "rehearsal_id"
    t.integer  "lesson_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "lesson_rehearsals", ["lesson_id"], name: "index_lesson_rehearsals_on_lesson_id", using: :btree
  add_index "lesson_rehearsals", ["rehearsal_id"], name: "index_lesson_rehearsals_on_rehearsal_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tags"
    t.integer  "topic_id"
    t.integer  "instructor_id"
    t.string   "privacy"
    t.string   "lesson_type"
    t.string   "language"
    t.string   "approval_status"
    t.string   "succession"
    t.string   "lesson_level"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "models", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.string   "title"
    t.string   "video_type"
    t.string   "token"
    t.string   "video_token"
    t.string   "script"
    t.string   "language"
    t.string   "privacy"
    t.string   "position_prior"
    t.integer  "watched"
    t.string   "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "practices", force: :cascade do |t|
    t.string   "token"
    t.string   "video_token"
    t.boolean  "completed",   default: false
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "practices", ["lesson_id"], name: "index_practices_on_lesson_id", using: :btree
  add_index "practices", ["user_id", "lesson_id"], name: "index_practices_on_user_id_and_lesson_id", unique: true, using: :btree
  add_index "practices", ["user_id"], name: "index_practices_on_user_id", using: :btree

  create_table "prompts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.string   "title"
    t.string   "video_type"
    t.string   "token"
    t.string   "video_token"
    t.string   "script"
    t.string   "language"
    t.string   "privacy"
    t.string   "position_prior"
    t.integer  "watched"
    t.string   "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "rehearsals", force: :cascade do |t|
    t.integer  "trainee_id"
    t.integer  "course_id"
    t.integer  "topic_id"
    t.integer  "lesson_id"
    t.integer  "group_id"
    t.string   "video_type"
    t.string   "token"
    t.string   "video_token"
    t.string   "script"
    t.boolean  "submission"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rehearsals", ["course_id"], name: "index_rehearsals_on_course_id", using: :btree
  add_index "rehearsals", ["group_id"], name: "index_rehearsals_on_group_id", using: :btree
  add_index "rehearsals", ["lesson_id"], name: "index_rehearsals_on_lesson_id", using: :btree
  add_index "rehearsals", ["topic_id"], name: "index_rehearsals_on_topic_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.date     "due_date"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topic_lessons", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tags"
    t.integer  "course_id"
    t.integer  "instructor_id"
    t.string   "privacy"
    t.string   "language"
    t.string   "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "user_role"
    t.boolean  "approval_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.integer  "role"
    t.integer  "age"
    t.string   "education"
    t.string   "race"
    t.string   "zip_code"
    t.string   "gender"
    t.string   "preferred_language"
    t.text     "bio"
    t.text     "skills"
    t.text     "experience"
    t.string   "website"
    t.string   "phone_number"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "profile_file_name"
    t.string   "profile_content_type"
    t.integer  "profile_file_size"
    t.datetime "profile_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "group_registrations", "courses"
  add_foreign_key "group_registrations", "groups"
  add_foreign_key "lesson_rehearsals", "lessons"
  add_foreign_key "lesson_rehearsals", "rehearsals"
  add_foreign_key "practices", "lessons"
  add_foreign_key "practices", "users"
  add_foreign_key "rehearsals", "courses"
  add_foreign_key "rehearsals", "groups"
  add_foreign_key "rehearsals", "lessons"
  add_foreign_key "rehearsals", "topics"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
