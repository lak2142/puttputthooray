# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach("db/colleges_lat_lng.csv") do |college|
  College.create(name: college[0], address: college[1], city: college[2], state: college[3], zip_code: college[4], website: college[5], lat: college[6], lon: college[7])
end
