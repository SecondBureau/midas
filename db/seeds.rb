# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "lipsum"

User.create :email => "danny@secondbureau.com", :password => "5ebe2294ecd0e0f08eab7690d2a6ee69"

Bank.create :name => "Bank"

InvoiceStatus.create :label => "Invoiced"
InvoiceStatus.create :label => "Paid"
InvoiceStatus.create :label => "Received"
InvoiceStatus.create :label => "Withdrew"

PaymentMode.create :label => "Danny"
PaymentMode.create :label => "Cash"
PaymentMode.create :label => "Gilles"
PaymentMode.create :label => "Bank Euro"

ToAccountant.create :label => "Yes"
ToAccountant.create :label => "No"
ToAccountant.create :label => "Wrong writing"

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
15000.times do 
  
  account = Account.all[rand(Account.count)]
  category = Category.all[rand(Category.count)]
  operation_date = account.opened_at + rand((account.closed_at || Time.now) - account.opened_at)
  label = Lipsum.generate(:words => rand(3) + 4, :start_with_lipsum => false)
  Entry.create(:category_id => category.id, :account_id => account.id, :src_amount_in_cents => rand(10000000), :operation_date => operation_date, :label => label)
  Rails.logger.info "#{Entry.last.id} - #{Entry.last.currency} - #{operation_date} - #{Entry.last.amount}"

end