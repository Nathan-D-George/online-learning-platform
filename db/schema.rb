# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_29_082947) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.string "body"
    t.boolean "correct", default: false
    t.integer "question_id", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "total"
    t.integer "course_id", null: false
    t.index ["course_id"], name: "index_assessments_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "course_id", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "marks", force: :cascade do |t|
    t.integer "achieved", default: 0
    t.integer "achievable"
    t.integer "quiz_id", null: false
    t.integer "user_id", null: false
    t.index ["quiz_id"], name: "index_marks_on_quiz_id"
    t.index ["user_id"], name: "index_marks_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "body"
    t.integer "quiz_id", null: false
    t.integer "answer"
    t.integer "total_marks", default: 1
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "name"
    t.integer "total_marks"
    t.integer "number_questions"
    t.integer "course_id", null: false
    t.integer "assessment_id", null: false
    t.index ["assessment_id"], name: "index_quizzes_on_assessment_id"
    t.index ["course_id"], name: "index_quizzes_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "teacher", default: false
    t.string "password_digest"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "assessments", "courses"
  add_foreign_key "courses", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "marks", "quizzes"
  add_foreign_key "marks", "users"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quizzes", "assessments"
  add_foreign_key "quizzes", "courses"
end
