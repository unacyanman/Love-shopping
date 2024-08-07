class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string "name"
      t.string "email"
      t.string "encrypted_password"
      t.text "introduction"
      t.timestamps
    end
  end
end
