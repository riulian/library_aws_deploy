class Book < ApplicationRecord
    paginates_per 10
    validates :title, presence: true,uniqueness: true
    has_many :books_users
    has_many :users, through: :books_users
    after_destroy :destroy_booksuser
    def destroy_booksuser
        self.books_users.destroy_all 
    end  
end
