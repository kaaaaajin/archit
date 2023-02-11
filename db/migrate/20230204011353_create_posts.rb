class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :architecture
      t.string :architect
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :body
      t.timestamps
    end
    
  end
end
