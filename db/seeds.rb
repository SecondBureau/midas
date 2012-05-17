# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create :email => "danny@secondbureau.com", :password => "5ebe2294ecd0e0f08eab7690d2a6ee69"

Account.create :label => "Danny"
Account.create :label => "Cash"
Account.create :label => "Gilles"
Account.create :label => "Bank Euro"
Account.create :label => "SPD"
Account.create :label => "ICBD"

Category.create :label => "Daily"
Category.create :label => "Equipment"
Category.create :label => "External"
Category.create :label => "Income"
Category.create :label => "Rental"
Category.create :label => "Salary"
Category.create :label => "Tax & Bank"
Category.create :label => "Travel"