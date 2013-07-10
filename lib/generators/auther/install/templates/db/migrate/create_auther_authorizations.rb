class CreateAutherAuthorizations < ActiveRecord::Migration
  def change
    create_table :auther_authorizations  do |t|
      t.references :user
      t.string :provider,   null: false
      t.string :uid,        null: false
      t.string :name,       null: false

      t.timestamps :null => false
    end

    add_index :auther_authorizations, :uid
  end
end
