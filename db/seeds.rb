# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Place.create(name: 'Blackhood', address: 'Chestnut street, San Francisco', gender: 'Restaurant', price: '$$')
Place.create(name: 'Japanese Garden', address: 'Golden Gate Park, San Francisco', gender: 'Museum', price: '$')
Place.create(name: 'Wall paintings', address: 'Mission district, San Francisco', gender: 'Art', price: 'Free')
