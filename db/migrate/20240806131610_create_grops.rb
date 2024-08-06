class CreateGrops < ActiveRecord::Migration[6.1]
  def change
    create_table :grops do |t|

      t.timestamps
    end
  end
end
