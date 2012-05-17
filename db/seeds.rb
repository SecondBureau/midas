# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "lipsum"

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

# entries
0.times do 
  
  account = Account.all[rand(Account.count)]
  category = Category.all[rand(Category.count)]
  operation_date = account.opened_at + rand((account.closed_at || Time.now) - account.opened_at)
  label = Lipsum.generate(:words => rand(3) + 4, :start_with_lipsum => false)
  Entry.create(:category_id => category.id, :account_id => account.id, :src_amount_in_cents => rand(10000000) * (rand(10)<5 ? -1 : +1), :operation_date => operation_date, :label => label)
  Rails.logger.info "#{Entry.last.id} - #{Entry.last.currency} - #{operation_date} - #{Entry.last.amount}"

end