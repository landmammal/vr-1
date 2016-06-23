# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


users = User.create([{ first_name:'Al', last_name:'Delcy', race:'Black', email:'aldelcy2000@gmail.com', password:'123456', password_confirmation:'123456', role: 0}])