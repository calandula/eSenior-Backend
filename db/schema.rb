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

ActiveRecord::Schema.define(version: 2019_01_08_100753) do

  create_table "friend_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friend_requests_on_friend_id"
    t.index ["user_id"], name: "index_friend_requests_on_user_id"
  end

  create_table "friendships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "invitaciones_quedades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "quedada_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quedada_id"], name: "fk_rails_34c2f49242"
    t.index ["user_id"], name: "fk_rails_85aa797de9"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "sender"
    t.string "receiver"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "title"
    t.boolean "read", default: false
    t.index ["receiver"], name: "index_messages_on_receiver"
  end

  create_table "pleasures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quedadas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "titulo"
    t.text "descripcion"
    t.date "fecha"
    t.time "hora"
    t.text "lugar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "tablero_id"
    t.index ["user_id"], name: "fk_rails_0191d5ad47"
  end

  create_table "recordatorios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "data"
    t.text "texto"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "time"
    t.index ["user_id"], name: "fk_rails_27f9e1c30f"
  end

  create_table "tableros", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "casillas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "filas"
    t.integer "columnas"
    t.bigint "quedada_id"
    t.index ["quedada_id"], name: "fk_rails_8d8d2deac5"
  end

  create_table "user_pleasures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pleasure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pleasure_id"], name: "fk_rails_dcb9d9a575"
    t.index ["user_id"], name: "fk_rails_396503114e"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
  end

  create_table "wall_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "texto"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "from"
  end

  add_foreign_key "friend_requests", "users"
  add_foreign_key "invitaciones_quedades", "quedadas"
  add_foreign_key "invitaciones_quedades", "users"
  add_foreign_key "quedadas", "users"
  add_foreign_key "recordatorios", "users"
  add_foreign_key "tableros", "quedadas"
  add_foreign_key "user_pleasures", "pleasures"
  add_foreign_key "user_pleasures", "users"
end
