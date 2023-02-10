class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :architecture, null: false
      t.string :architect, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.text :body, null: false
      
      t.timestamps
    end
  end
end
