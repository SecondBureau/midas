# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# First user
User.new({:email => "romain@secondbureau.com", :password => "admin01", :password_confirmation => "admin01" }).save(:validate=>false)

# Categories
%w[ Salary Rental Daily External Tax&Bank Equipement Travel Income].each {|c| Category.find_or_create_by_label(:label => c)}

# Accounts
seeds_path = File.join(File.dirname(__FILE__), 'seeds')

Dir["#{seeds_path}/*"].select { |file| /(yml)$/ =~ file }.sort.each do |file|
  #puts file
  klass = File.basename(file, '.yml').gsub(/[0-9]+\-/,'').singularize.humanize.constantize
  #YAML.load_file(file).each  do |key, params|
  YAML::load(ERB.new(IO.read(file)).result).each  do |key, params|
    conditions = {}
    klass = params['type'].constantize unless params['type'].nil?
    unless params['uniq'].nil?
      params['uniq'] = [params['uniq']] unless params['uniq'].is_a?(Array)
      params['uniq'].each {|c| conditions[c.to_sym] = params[c]}
      params.delete('uniq')
      o = klass.find(:first, :conditions => conditions) || klass.new
    else
      o = klass.new
    end
    #o.update_attributes(params)
    params.each do |att, val|
      if att[-3,3].eql?('_id')
        val = att.gsub('_id','').capitalize.constantize.where(eval(val)).first.id
      end
      if att[-4,4].eql?('_ids')
        val = [val] unless val.is_a?(Array)
        vals = []
        val.each {|v| vals << att.gsub('_ids','').capitalize.constantize.where(eval(v)).first.id}
        val = vals
      end
      if att[-10,10].eql?('_textilize')
        att = att.gsub('_textilize','')
        val = RedCloth.new(val).to_html
      end
      o.send("#{att}=", val)
    end
    o.save!
  end
end

# Import of previous data

file = File.open('db/seeds/previous_entries.csv')
@all = []
CSV.foreach file do |row|
  entry = Entry.new
  
  begin
    entry.operation_date = Date.strptime(row[1], '%m/%d/%Y')+1.day
  
    
    if row[2]
      category = row[2]
      if row[2] == "Gcro"
  	    category = "Gilles"
  	  end
  	  entry.category = Category.find(:first, :conditions => ["lower(label) = ?", category.downcase])
    end
  
    if row[3]
      account = row[3]
  	  if row[3].downcase == "bank 2"
  		  account = "SPD CNY"
  	  elsif row[3].downcase == "bank"
  		  account = "ICBC CNY"
  	  elsif row[3].downcase == "Bank €"
  		  account = "SPD EUR"
  	  end
  	  entry.account = Account.find(:first, :conditions => ["lower(label) = ?", account.downcase])
    end
    
    entry.label = row[4]
    str = row[5].to_s.tr("()", '')
    if entry.category && entry.category.label == "Income"
      entry.src_amount_in_cents = str.to_i*100
    else
      entry.src_amount_in_cents = str.to_i*-100
    end
    entry.cheque_num = row[7]
    entry.invoice_num = row[8]
    @all << entry
  rescue Exception=>e
  	# Exception! most of the time, because the format of one of the data is totally wrong : not a date, or not a integer, etc.
  end
  
end
    
Entry.transaction do
  @all.each do |e|
    entry = Entry.find(:first, :conditions => ["label = ? AND operation_date = ? AND src_amount_in_cents = ?", e.label, e.operation_date, e.src_amount_in_cents])
    e.save unless entry
  end
end