class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

	  t.string :username
	  t.string :password_encrypted
	  t.string :password_salt
	  t.string :email
	  t.string :first_name
	  t.string :last_name
	  t.integer :gender
	  
      t.timestamps null: false
    end
  end
end
