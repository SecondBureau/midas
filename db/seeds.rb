# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

file = File.open('db/seeds/import.csv')
@all = []
CSV.foreach file do |row|
  entry = Entry.new
  entry.operation_date = Date.strptime(row[1], '%m/%d/%Y')+1.day
  entry.category = Category.find(:first, :conditions => ["lower(label) = ?", row[2].downcase]) if row[2]
  entry.account = Account.find(:first, :conditions => ["lower(label) = ?", row[3].downcase]) if row[3]
  entry.label = row[4]
  str = row[5].to_s.tr("()", '')
  
  if entry.category && entry.category.id == 8
    entry.src_amount_in_cents = str.to_i*100
  else
    entry.src_amount_in_cents = str.to_i*-100
  end
  entry.cheque_num = row[7]
  entry.invoice_num = row[8]
  @all << entry
end
    
Entry.transaction do
  @all.each do |e|
    entry = Entry.find(:first, :conditions => ["label = ? AND operation_date = ? AND src_amount_in_cents = ?", e.label, e.operation_date, e.src_amount_in_cents])
    e.save unless entry
  end
end