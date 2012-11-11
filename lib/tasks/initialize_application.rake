# encoding: utf-8
require 'csv'



desc 'Init data'
task :init_midas_data => :environment do

  I18n.locale = :en

  include ActionView::Helpers::TextHelper


  # Users, Roles & Groups
  Refinery::User.all.each {|u| u.destroy }
  Refinery::Role.all.each {|r| r.destroy }

  # Roles
  %w[Refinery Superuser].each {|r| Refinery::Role.[](r.downcase.to_sym)}

  # SuperAdmin
  admin = Refinery::User.new(:username => 'gilles', :password => 'secret', :password_confirmation => 'secret', :firstname => 'Gilles', :lastname => 'Crofils', :email => 'gilles@secondbureau.com')
  admin.roles = ['Refinery', 'Superuser'].collect { |r| Refinery::Role[r.downcase.to_sym] }
  admin.save! # we need to save it first.
  admin.plugins = Refinery::Plugins.registered.collect(&:name)

  # Financial Officer
  danny = Refinery::User.new(:username => 'danny', :password => 'secret', :password_confirmation => 'secret', :firstname => 'Danny', :lastname => 'Yang', :email => 'danny@secondbureau.com')
  danny.roles = ['Refinery'].collect { |r| Refinery::Role[r.downcase.to_sym] }
  danny.save! # we need to save it first.
  danny.plugins = ['entries']

  # Categories
   Refinery::Midas::Category.all.each {|c| c.destroy }

  ['604000', 'Achat Etudes et Prestation de Services',
  '606400', 'Stationary',
  '606500', 'Hardware',
  '614010', 'Loyers',
  '614010.01', 'Zhonyu Plaza 1515',
  '614010.02', 'Zhonyu Plaza 1516',
  '614020', 'Charges locatives',
  '614020.01', 'Zhonyu Plaza 1515',
  '614020.02', 'Zhonyu Plaza 1516',
  '614030', 'Décoration',
  '614030.01', 'Zhonyu Plaza 1515',
  '614030.02', 'Zhonyu Plaza 1516',
  '618100', 'Documentation',
  '618500', 'Frais de Colloque',
  '622600', 'Honoraires',
  '622600.01', 'RMG Selection',
  '622600.02', 'China Solution',
  '622600.03', 'Accounting',
  '622600.04', 'Fesco',
  '622600.05', 'Divers RH',
  '623400', 'Cadeaux à la clientèle',
  '623700', 'Publicités & objets marketing',
  '624400', 'Transports Administratifs',
  '625100', 'Voyages & Déplacements',
  '625600', 'Missions',
  '625700', 'Réception',
  '625710', 'Team Lunch',
  '625720', 'Business Lunch',
  '626000', 'Téléphone & Internet',
  '628100', 'Cotisations',
  '641100', 'Net Salaries',
  '641100.01', 'Gilles Crofils',
  '641100.03', 'Zhang Weihan',
  '641100.04', 'Yang Huachang',
  '641100.05', 'Li Zhe',
  '641100.06', 'Li Lin',
  '641100.07', 'Romain Binaux',
  '641100.08', 'Zhang Yang',
  '641100.09', 'Wang Hongyan',
  '641100.10', 'Meng Xianli',
  '641100.11', 'Ren Lihong',
  '645100', 'Social Taxes',
  '645110', 'Employer Social Taxes',
  '645110.01', 'Gilles Crofils',
  '645110.03', 'Zhang Weihan',
  '645110.04', 'Yang Huachang',
  '645110.05', 'Li Zhe',
  '645110.06', 'Li Lin',
  '645110.07', 'Romain Binaux',
  '645110.08', 'Zhang Yang',
  '645110.09', 'Wang Hongyan',
  '645110.10', 'Meng Xianli',
  '645110.11', 'Ren Lihong',
  '645115', 'Employer Housing Fund',
  '645115.01', 'Gilles Crofils',
  '645115.03', 'Zhang Weihan',
  '645115.04', 'Yang Huachang',
  '645115.05', 'Li Zhe',
  '645115.06', 'Li Lin',
  '645115.07', 'Romain Binaux',
  '645115.08', 'Zhang Yang',
  '645115.09', 'Wang Hongyan',
  '645115.10', 'Meng Xianli',
  '645115.11', 'Ren Lihong',
  '645120', 'Employee Social Taxes',
  '645120.01', 'Gilles Crofils',
  '645120.03', 'Zhang Weihan',
  '645120.04', 'Yang Huachang',
  '645120.05', 'Li Zhe',
  '645120.06', 'Li Lin',
  '645120.07', 'Romain Binaux',
  '645120.08', 'Zhang Yang',
  '645120.09', 'Wang Hongyan',
  '645120.10', 'Meng Xianli',
  '645120.11', 'Ren Lihong',
  '645125', 'Employee Housing Fund',
  '645125.01', 'Gilles Crofils',
  '645125.03', 'Zhang Weihan',
  '645125.04', 'Yang Huachang',
  '645125.05', 'Li Zhe',
  '645125.06', 'Li Lin',
  '645125.07', 'Romain Binaux',
  '645125.08', 'Zhang Yang',
  '645125.09', 'Wang Hongyan',
  '645125.10', 'Meng Xianli',
  '645125.11', 'Ren Lihong',
  '645130', 'Individual Income Tax',
  '645130.01', 'Gilles Crofils',
  '645130.03', 'Zhang Weihan',
  '645130.04', 'Yang Huachang',
  '645130.05', 'Li Zhe',
  '645130.06', 'Li Lin',
  '645130.07', 'Romain Binaux',
  '645130.08', 'Zhang Yang',
  '645130.09', 'Wang Hongyan',
  '645130.10', 'Meng Xianli',
  '645130.11', 'Ren Lihong',
  '648000', 'Visas & expenses',
  '647000', 'Training',
  '647000.01', 'Gilles Crofils',
  '661600', 'Bank Fees & Agios',
  '695000', 'Taxes',
  '695100', 'Income Tax',
  '695200', 'V.A.T.',
  '695300', 'Business Tax',
  '760000', 'Bank Interests',
  '760100', 'Prestation de Services',
  '760100.0012', 'Bernard Controls',
  '760100.0014', 'WinterSweet',
  '760100.0017', 'China Trade Winds',
  '760100.0018', 'Fimasys',
  '760100.0020', 'Paraland',
  '760100.0000', 'Second Bureau',
  '708300', 'Locations diverses',
  '708300.0024', 'SC & S Transport',
  '708300.0025', 'lesachats.fr',
  '580000', 'internal transfer'].each_slice(2)  do |c, t|
    
    category,subcategory = c.split('.')
    if subcategory.nil?
      parent = Refinery::Midas::Category.create!(:code => c, :title => t)
      c = "#{c}.0"
    else
      parent = Refinery::Midas::Category.find_by_code(category)
    end
    
    Refinery::Midas::Category.create!(:code => "#{c}", :title => t, :parent_id => parent.id)
        
  end

  # Accounts
   Refinery::Midas::Account.all.each {|a| a.destroy }
   [  'Cash',               '',               true,   'cny',  false,  'Cash',   0,          '2012-12-01',   nil,            'All cash operations with official invoice',
      'Danny',              '',               true,   'cny',  false,  'Cash',   0,          '2012-12-01',   nil,            'All cash operations with official invoice',
      'Gilles',             '',               true,   'cny',  true,   'Cash',   0,          '2012-12-01',   nil,            'Cash operations without official invoice',
      'ICBC CNY',           '',               false,  'cny',  false,  'Bank',   8242,       '2010-12-01',   '2011-12-31',   'Legacy account closed in 2011',
      'SPD CNY',            '',               true,   'cny',  false,  'Bank',   0,          '2011-12-01',   nil,            'Current Beijing main account',
      'SPD EURO',           '',               true,   'eur',  false,  'Bank',   0,          '2011-12-01',   nil,            'Current Beijing main account',
      'HSBC EURO Savings',  '817-154149-838', true,   'eur',  false,  'Bank',   1,          '2011-12-01',   nil,            'HSBC Lalaso Hongkong',
      'HSBC HKD Savings',   '817-154149-838', true,   'hkd',  false,  'Bank',   33187,      '2011-12-01',   nil,            'HSBC Lalaso Hongkong',
    ].each_slice(10)  do |title, number, active, currency, confidential, group, opening_balance_in_cents, opened_on, closed_on, description|
       r = Refinery::Midas::Account.new(  :title => title,
                                          :number => number,
                                          :description => description,
                                          :active => active,
                                          :currency => currency,
                                          :confidential => confidential,
                                          :group => group,
                                          :opening_balance_in_cents => opening_balance_in_cents,
                                          :opened_on => Date.parse(opened_on),
                                          :closed_on => closed_on.nil? ? nil : Date.parse(closed_on))
      r.reconciliated_on = Date.parse(opened_on)
      r.reconciliated_in_cents = opening_balance_in_cents
      r.reconciliated_at = Time.now
      r.save!
    end

   # Entries
   Refinery::Midas::Entry.all.each {|e| e.destroy }

   [ 'HSBC EURO Savings',   '760100.0000',  'eur',    3600000,    '2010-12-16',   'Facture xxx',
     'HSBC EURO Savings',   '580000',     'eur',    -3550000,   '2010-12-21',   'Capital Injection to ICBC CNY',
     'HSBC EURO Savings',   '661600',     'eur',    -4670,      '2010-12-21',   'Frais de transfert HSBC',
     'HSBC EURO Savings',   '760000',     'eur',    7,          '2010-12-28',   'Bank Interests',
     'HSBC EURO Savings',   '661600',     'eur',    -12084,     '2011-07-30',   'Bank Fees',
     'HSBC EURO Savings',   '580000',     'eur',    -3305,      '2011-11-07',   'Transfer to HSBC HKD Savings',
     'HSBC EURO Savings',   '760000',     'eur',    1,          '2011-12-28',   'Bank Interests',
     'HSBC EURO Savings',   '580000',     'eur',    -2014,      '2011-12-30',   'Transfer to HSBC HKD Savings',
     'HSBC EURO Savings',   '580000',     'eur',    -2002,      '2012-02-01',   'Transfer to HSBC HKD Savings',
     'HSBC EURO Savings',   '580000',     'eur',    -3948,      '2012-03-08',   'Transfer to HSBC HKD Savings',
     'HSBC EURO Savings',   '580000',     'eur',    -10000,     '2012-04-25',   'Transfer to HSBC HKD Savings',
     'HSBC EURO Savings',   '760000',     'eur',    5,          '2012-06-28',   'Bank Interests',
     'HSBC EURO Savings',   '580000',     'eur',    -3850,      '2012-10-30',   'Transfer to HSBC HKD Savings',
     'HSBC EURO Savings',   '760100.0014','eur',    248214,     '2012-04-30',   'Prepayment',
     'HSBC EURO Savings',   '760100.0017','eur',    120000,     '2012-04-30',   'Prepayment',
     'HSBC EURO Savings',   '760100.0017','eur',    250315,     '2012-09-21',   'Balance payment',
     'HSBC HKD Savings',    '661600',     'hkd',    -15000,     '2010-12-04',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    26753,      '2011-07-30',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2011-08-04',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2011-09-05',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2011-10-07',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2011-11-04',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2011-12-05',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-01-06',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-02-04',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-03-05',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-04-10',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-05-05',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-06-05',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-07-05',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-08-04',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-09-05',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -20000,     '2012-10-06',   'Monthly Service Fee',
     'HSBC HKD Savings',    '661600',     'hkd',    -105,       '2011-10-28',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -72,        '2011-11-28',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -161,       '2011-12-28',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -168,       '2012-01-28',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -196,       '2012-02-28',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -84,        '2012-03-28',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -98,        '2012-04-27',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -138,       '2012-09-28',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    -326,       '2012-10-30',   'Debit Interest',
     'HSBC HKD Savings',    '661600',     'hkd',    35237,      '2011-11-07',   'Transfer from HSBC EURO Savings',
     'HSBC HKD Savings',    '661600',     'hkd',    20175,      '2011-12-30',   'Transfer from HSBC EURO Savings',
     'HSBC HKD Savings',    '661600',     'hkd',    20182,      '2012-01-02',   'Transfer from HSBC EURO Savings',
     'HSBC HKD Savings',    '661600',     'hkd',    40252,      '2012-03-08',   'Transfer from HSBC EURO Savings',
     'HSBC HKD Savings',    '661600',     'hkd',    102118,     '2012-04-25',   'Transfer from HSBC EURO Savings',
     'HSBC HKD Savings',    '661600',     'hkd',    38484,      '2012-10-30',   'Transfer from HSBC EURO Savings'
     ].each_slice(6) do |account, category, currency, src_amount_in_cents, valid_after, title|
       c,s = category.split('.')
       category = "#{c}.0" if s.nil?
       midas_account = Refinery::Midas::Account.find_by_title(account)
       midas_category = Refinery::Midas::Category.find_by_code(category)
       Refinery::Midas::Entry.create!(  :account => midas_account,
                                        :category => midas_category,
                                        :currency => currency,
                                        :src_amount_in_cents => src_amount_in_cents,
                                        :valid_after => Date.parse(valid_after),
                                        :title => title
                                      )
  end


  i = 0
  CSV.foreach(Rails.root.join('db', 'seeds', 'entries.csv')) do |id, date, category, account, title, amount, employee, ratio, status, num1, num2, docid, accountant|
    i += 1


    account_title = case account.downcase.strip
      when 'bank' then 'ICBC CNY'
      when 'bank 2' then 'SPD CNY'
      when 'bank euro' then 'SPD EURO'
      when 'cash' then 'Cash'
      when 'danny' then 'Danny'
      when 'gcro' then 'Gilles'
      else nil
      end

    c,s = category.split('.')
    category = "#{c}.0" if s.nil?
       
    midas_account = Refinery::Midas::Account.find_by_title(account_title) unless account_title.nil?
    midas_category = Refinery::Midas::Category.find_by_code(category)

    if midas_account.nil? || midas_category.nil?
      puts "#{i} account >#{account.downcase}< inconnu" if midas_account.nil?
      puts "#{i} category >#{category}< inconnue" if midas_category.nil?
    else
        begin
        Refinery::Midas::Entry.create!(  :account => midas_account,
                                      :category => midas_category,
                                      :currency => midas_account.currency,
                                      :src_amount_in_cents => amount.split(',').each_slice(2).collect{|a,b| "#{a}#{(b||'').ljust(2, '0')}"}.first,
                                      :valid_after => Date.parse(date),
                                      :title => title
                                    )
      rescue Exception => e
        puts "****************  Erreur #{e} parsing #{i} #{id}, #{date}, #{category}, #{account}, #{title}, #{amount}, #{midas_account}, #{midas_category}"
      end
    end
 end

 [  'SPD CNY',            '2012-11-01', 47349.32,
    'HSBC EURO Savings',  '2012-09-30', 6305.2,
    'HSBC HKD Savings',   '2012-10-30', 0.4,
    'ICBC CNY',           '2011-12-31', 0.0,
    'SPD EURO',           '2012-11-10', 0.91
   ].each_slice(3) do |account, reconciliation_date, reconciation_amount|
     midas_account = Refinery::Midas::Account.find_by_title(account)
     if midas_account.balance(reconciliation_date).eql?(reconciation_amount)
       entry_ids = midas_account.entries.where('valid_after <= ?',reconciliation_date).collect(&:id)
       midas_account.reconciliate entry_ids, reconciliation_date
       midas_account.save!
    end
   end



 end
