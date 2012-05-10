# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'romain@secondbureau.com', password: 'secret')

Category.create(:label => 'Salary')
Category.create(:label => 'Rental')
Category.create(:label => 'Daily')
Category.create(:label => 'External')
Category.create(:label => 'Tax & Bank')
Category.create(:label => 'Equipment')
Category.create(:label => 'Travel')
Category.create(:label => 'Income')

Bank.create(:nom => 'Bank')

InvoiceStatus.create(:label => 'Invoiced')
InvoiceStatus.create(:label => 'Paid')
InvoiceStatus.create(:label => 'Received')
InvoiceStatus.create(label => 'Withdrew')

PaymentMode.create(:label => 'Danny')
PaymentMode.create(:label => 'Cash')
PaymentMode.create(:label => 'Gilles')
PaymentMode.create(:label => 'Bank €')

ToAccountant.create(:label => 'Yes')
ToAccountant.create(:label => 'No')
ToAccountant.create(:label => 'Wrong writing')