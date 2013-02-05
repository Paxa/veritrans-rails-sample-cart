# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create product
Product.create([{ name: 'tshirt', price: 100000 }, { name: 'bag', price: 350000 }, { name: 'shoes', price: 250000 }, { name: 'jeans', price: 175000 }])