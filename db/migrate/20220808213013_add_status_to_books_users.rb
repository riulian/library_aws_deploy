class AddStatusToBooksUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :books_users, :status, :string
  end
end
