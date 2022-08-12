class AddStatusToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :status, :integer
    add_index :books, :status
  end
end
