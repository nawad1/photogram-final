class AddColumnNameToTableName < ActiveRecord::Migration[7.1]
  def change
    add_column :likes, :user_id, :integer
  end
end
