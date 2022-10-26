# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

=begin
    b=Book.create([{ title: "Book 1" }, {title: "Book 2" },{title: "Book 3"},
        {title: "Book 4"},{title: "Book 5"},{title: "Book 6"},{title: "Book 7"},{title: "Book 8"},{title: "Book 9"}])
   

    u=User.create([{ email: "1@1.com",password: '111111',password_confirmation: '111111',role: 1 },
            { email: "2@2.com",password: '111111',password_confirmation: '111111',role: 0},
            { email: "3@3.com",password: '111111',password_confirmation: '111111',role: 0 },
            { email: "4@4.com",password: '111111',password_confirmation: '111111',role: 0 },
            { email: "5@5.com",password: '111111',password_confirmation: '111111',role: 0 },
            { email: "6@6.com",password: '111111',password_confirmation: '111111',role: 0 },
            { email: "7@7.com",password: '111111',password_confirmation: '111111',role: 0 },
            { email: "8@8.com",password: '111111',password_confirmation: '111111',role: 0 },
            { email: "9@9.com",password: '111111',password_confirmation: '111111',role: 0 }])
            
=end

Book.delete_all
User.delete_all
require "faker"
a=0
u=User.new(email: Faker::Internet.email,password: '111111',password_confirmation: '111111',role: 1)
u.save
100.times do
    
    b=Book.new(title: Faker::Book.title)
    b.save
    if a==1
        u=User.new(email: Faker::Internet.email,password: '111111',password_confirmation: '111111',role: 0)
        u.save
    end
    a=1    
end

