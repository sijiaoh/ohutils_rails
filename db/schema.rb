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

ActiveRecord::Schema.define(version: 2022_01_30_161814) do

  create_table "peer_reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "space_id", null: false
    t.string "title", null: false
    t.string "hashid"
    t.integer "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashid"], name: "index_peer_reviews_on_hashid", unique: true
    t.index ["space_id"], name: "index_peer_reviews_on_space_id"
    t.index ["user_id"], name: "index_peer_reviews_on_user_id"
  end

  create_table "peer_reviews_participations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "peer_review_id", null: false
    t.string "hashid"
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashid"], name: "index_peer_reviews_participations_on_hashid", unique: true
    t.index ["peer_review_id"], name: "index_peer_reviews_participations_on_peer_review_id"
    t.index ["user_id", "peer_review_id"], name: "index_peer_reviews_participations_on_user_id_and_peer_review_id", unique: true
    t.index ["user_id"], name: "index_peer_reviews_participations_on_user_id"
  end

  create_table "peer_reviews_reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "hashid"
    t.bigint "peer_review_id", null: false
    t.bigint "reviewer_participation_id", null: false
    t.bigint "reviewee_participation_id", null: false
    t.integer "fun", null: false
    t.integer "technical", null: false
    t.integer "creativity", null: false
    t.integer "composition", null: false
    t.integer "growth", null: false
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashid"], name: "index_peer_reviews_reviews_on_hashid", unique: true
    t.index ["peer_review_id"], name: "index_peer_reviews_reviews_on_peer_review_id"
    t.index ["reviewee_participation_id"], name: "index_peer_reviews_reviews_on_reviewee_participation_id"
    t.index ["reviewer_participation_id", "reviewee_participation_id"], name: "index_peer_reviews_reviews_on_reviewer_p_id_and_reviewee_p_id", unique: true
    t.index ["reviewer_participation_id"], name: "index_peer_reviews_reviews_on_reviewer_participation_id"
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.boolean "published", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "space_id", null: false
    t.boolean "copy_protect", default: true, null: false
    t.boolean "markdown", default: false, null: false
    t.string "hashid"
    t.index ["hashid"], name: "index_posts_on_hashid", unique: true
    t.index ["space_id"], name: "index_posts_on_space_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "social_profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "provider", null: false
    t.string "uid", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_social_profiles_on_provider_and_uid", unique: true
    t.index ["user_id", "provider"], name: "index_social_profiles_on_user_id_and_provider", unique: true
    t.index ["user_id"], name: "index_social_profiles_on_user_id"
  end

  create_table "spaces", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "display_on_home", default: false, null: false
    t.string "hashid"
    t.index ["hashid"], name: "index_spaces_on_hashid", unique: true
  end

  create_table "student_profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "hashid"
    t.string "student_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashid"], name: "index_student_profiles_on_hashid", unique: true
    t.index ["student_number"], name: "index_student_profiles_on_student_number", unique: true
    t.index ["user_id"], name: "index_student_profiles_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "hashid"
    t.string "name", default: "", null: false
    t.index ["hashid"], name: "index_users_on_hashid", unique: true
  end

  create_table "users_roles", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "peer_reviews", "spaces"
  add_foreign_key "peer_reviews", "users"
  add_foreign_key "peer_reviews_participations", "peer_reviews"
  add_foreign_key "peer_reviews_participations", "users"
  add_foreign_key "peer_reviews_reviews", "peer_reviews"
  add_foreign_key "peer_reviews_reviews", "peer_reviews_participations", column: "reviewee_participation_id"
  add_foreign_key "peer_reviews_reviews", "peer_reviews_participations", column: "reviewer_participation_id"
  add_foreign_key "posts", "spaces"
  add_foreign_key "posts", "users"
  add_foreign_key "social_profiles", "users"
  add_foreign_key "student_profiles", "users"
end
