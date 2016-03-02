class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
	  t.references :asset, polymorphic: true, index: true
	  
	  t.string :name
	  t.string :file_extension
	  t.string :location
	  t.string :tag
	  

      t.timestamps null: false
    end
  end
end
