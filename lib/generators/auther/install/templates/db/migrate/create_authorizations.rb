class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations  do |t|
      t.references :user
      t.string :provider,   null: false
      t.string :uid,        null: false
      t.string :name,       null: false

      t.timestamps :null => false
    end

    add_index :authorizations, :uid
  end
end
