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

ActiveRecord::Schema.define(version: 20180215170242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.string "background_color", default: "#999999"
    t.string "background_image"
    t.boolean "status", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 1
    t.string "slug"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.string "slug"
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "background_color", default: "#999999"
    t.boolean "status", default: true
    t.text "description"
    t.string "job_position"
    t.string "url"
    t.string "font"
    t.string "location"
    t.float "salary"
    t.string "salary_currency", default: "CAD"
    t.string "salary_period", default: "Annual"
    t.string "employment_type"
    t.string "work_hours"
    t.datetime "time_commute"
    t.float "distance_commute"
    t.string "resume_file"
    t.text "cover_letter"
    t.boolean "accept_remote", default: false
    t.datetime "date_posted"
    t.datetime "due_date"
    t.text "education_requirements"
    t.text "language_requeriments"
    t.text "experience_requirements"
    t.text "responsabilities"
    t.text "qualifications"
    t.text "skills"
    t.text "incentive_compensation"
    t.text "benefits"
    t.float "latitude"
    t.float "longitude"
    t.index ["list_id"], name: "index_cards_on_list_id"
    t.index ["name"], name: "index_cards_on_name"
    t.index ["slug"], name: "index_cards_on_slug"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.integer "position", default: 1
    t.string "background_color", default: "#999999"
    t.string "image"
    t.boolean "status", default: true
    t.string "slug"
    t.bigint "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_lists_on_board_id"
    t.index ["name"], name: "index_lists_on_name"
    t.index ["slug"], name: "index_lists_on_slug"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "alternate_name"
    t.string "email"
    t.string "image"
    t.string "telephone"
    t.string "mobile"
    t.string "address_formatted_address"
    t.string "address_street_number"
    t.string "address_street_name"
    t.string "address_street"
    t.string "address_city"
    t.string "address_zip_code"
    t.string "address_department"
    t.string "address_department_code"
    t.string "address_state"
    t.string "address_state_code"
    t.string "address_country"
    t.string "address_country_code"
    t.float "address_lat"
    t.float "address_lng"
    t.string "headline"
    t.text "summary"
    t.string "current_position"
    t.string "linkedin_profile"
    t.string "twitter_profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 1
    t.string "api_key"
    t.bigint "person_id"
    t.string "slug"
    t.string "image"
    t.string "uid"
    t.string "provider"
    t.string "oauth_token"
    t.string "oauth_secret"
    t.text "oauth_raw_data"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["person_id"], name: "index_users_on_person_id", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boards", "users"
  add_foreign_key "cards", "lists"
  add_foreign_key "lists", "boards"
end
