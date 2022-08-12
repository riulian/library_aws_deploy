class CreateBooksUser < ActiveRecord::Migration[7.0]
  def change
    create_table :books_users do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :status

      t.timestamps
    end
  end
end
