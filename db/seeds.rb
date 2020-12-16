# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.destroy_all
Employee.destroy_all

restaurant_1 = Restaurant.create(name: "Fogo De Chao")
restaurant_2 = Restaurant.create(name: "Gamine")
restaurant_3 = Restaurant.create(name: "Hookfish")
restaurant_4 = Restaurant.create(name: "Zen Yai")

Employee.import_from_csv

