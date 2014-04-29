class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
    	t.string :body
    	t.integer :user_id
    	t.integer :album_id

      t.timestamps
    end
  end
end
