class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :comment_count
      t.string :email
      t.string :password
      t.integer :like_count
      t.boolean :private
      t.string :username

      t.timestamps
    end
  end
end
