class Entry < ActiveRecord::Base
  
  attr_accessible :label, :category_id, :account_id, :src_amount_in_cents,  :cheque_num, :invoice_num, :operation_date, :status
  
  belongs_to :account, :inverse_of => :entries
  belongs_to :category, :inverse_of => :entries
  
  before_validation :set_currency, :set_amount
  
  scope :validated, where('accountant_status = ?', 'sent')
  scope :by_date, lambda{ |after, before| where(:operation_date => after..before) }
  
  def self.mon_filtre(after, before=nil)
  before = after + 3600 if before.nil?
  where(:operation_date => after..before)
  
  end

  
  def amount
    amount_in_cents / 100.0
  end
  
  def self.datas_table_main(params=[])  

    start_date = Date.new(0, 1, 1)
    end_date = Date.new(3000, 12, 1)

  	if params[:date] && !params[:date][:year].nil? && !params[:date][:year].empty?

  	  search_year = params[:date][:year].to_i
  	  
  	  if !params[:date][:month].blank? 
      
        search_month = params[:date][:month].to_i
      
        start_date = Date.new(search_year, search_month, 1)
        end_date = Date.new(search_year, search_month, 1) + 1.month
      
      elsif
      
      	search_month = 1
      
        start_date = Date.new(search_year, search_month, 1)
        end_date = Date.new(search_year, search_month, 1) + 1.year

      end
    end
    
    #entries = Entry.all 
    
    #entries = entries.by_date start_date, end_date if true
    
    #entree = entries.xxxx unless params[:search][:category_id].nil?
    
    if params[:search] && !params[:search][:category_id].nil? && !params[:search][:category_id].empty?
        request = Entry.order("operation_date DESC").where(:operation_date => (start_date)..(end_date)).where(:category_id => params[:search][:category_id].to_i)
    elsif params[:search] && !params[:search][:label].nil? && !params[:search][:label].empty?
        request = Entry.order("operation_date DESC").where(:operation_date => (start_date)..(end_date)).where("label LIKE :label", {:label => "%#{params[:search][:label]}%"})
    else
        request = Entry.order("operation_date DESC").where(:operation_date => (start_date)..(end_date))
    end
    
    {
      :cols => [['string', 'Date'], ['string', 'Description'], ['string', 'Category'], ['number', 'Amount (CNY)'], ['string', 'Invoice'], ['string', 'Cheque'], ['string', 'Accountant']],
      :rows => request.inject([]) do |entries, entry|
        date        = I18n.localize(entry.operation_date, :format => :default)
        description = entry.label
        category    = entry.category.label
        amount      = entry.amount
        invoice     = entry.invoice_num
        cheque      = entry.cheque_num
        accountant  = entry.accountant_status
        entries << [date, description, category, amount, invoice, cheque, accountant]
        entries
       end
     }
  end
  
  def test_DEPRECATED

    {
    
      :cols => [['string', 'Date'], ['string', 'Description'], ['string', 'Category'], ['number', 'Amount (CNY)'], ['string', 'Invoice'], ['string', 'Cheque'], ['string', 'Accountant']],
      #:rows => Entry.where("id < ?", 300).inject([]) do |entries, entry|
      :rows => request.inject([]) do |entries, entry|
        date        = I18n.localize(entry.operation_date, :format => :default)
        description = entry.label
        category    = entry.category.label
        amount      = entry.amount
        invoice     = entry.invoice_num
        cheque      = entry.cheque_num
        accountant  = entry.accountant_status
        entries << [date, description, category, amount, invoice, cheque, accountant]
        entries
       end, 
      :options => {
        :height => params[:h] || '100%',
        :width => params[:w] || '100%',
        :showRowNumber => true,
        :page => 'enable',
        :pageSize => 25,
        :allowHtml => true
      },
      :formatters => {
          3 => {prefix: '', negativeColor: 'red', negativeParens: true}
        }
    }
  end
  
  
  def self.datas_table_categories(params=[])
    
      entries = Entry.all.group_by{ |e| [e.operation_date.beginning_of_month, e.category_id] }.inject({}) do |result, entries|
        result[entries.first] = entries.last.collect(&:amount_in_cents).inject {|r, entry| r + entry} 
        result
       end
       
       from = Time.parse('2011-01-01 00:00:00 UTC')
       to   = Time.now.beginning_of_month
     {  
      :cols => [['string', 'month']] + Category.all.inject([]) do |cols, item| 
        cols << ['number', item.label] 
        cols << ['number', 'Balance']
        cols
      end + [['number', 'TOTAL']] + [['number', '']],
      :rows => (from.to_date..to.to_date).select {|_| _.day.eql?(1)}.inject([]) do |rows, day|
        row = [I18n.localize(day, :format => :table_header)] + Category.all.collect(&:id).inject([]) do |row, category_id|
           # amount of the month for the category
           row << (entries[[day.to_time(:utc), category_id]] || 0) / 100.0
           # sum of amounts for previous month for the category
           row << entries.select{|(date, cat_id), amount| date <= day.to_time(:utc) && cat_id.eql?(category_id)}.values.sum / 100.0
           row
        end
        # sum of amounts for all categories
        row << entries.select{|(date, cat_id), amount| date.eql?(day.to_time(:utc)) }.values.sum / 100.0
        # sum of amounts for previous months for all categories
        row << entries.select{|(date, cat_id), amount| date <= day.to_time(:utc)}.values.sum / 100.0
        rows << row
        rows
      end,
      :options => {
        :height => params[:h] || '300px',
        :width => params[:w] || '100%',
        :showRowNumber => true,
        :page => 'enable',
        :pageSize => 30,
        :allowHtml => true,
        :sort => 'disable'
      },
      :formatters => (0..(2 * Category.all.count + 1)).inject({}) do |formatters, category|
          formatters[formatters.count + 1] = {prefix: '', negativeColor: 'red', negativeParens: true}
          formatters
        end 
    }
  end
  
  def self.datas_table_accounts(params=[])
    
      entries = Entry.all.group_by{ |e| [e.operation_date.beginning_of_month, e.account_id] }.inject({}) do |result, entries|
        result[entries.first] = entries.last.collect(&:amount_in_cents).inject {|r, entry| r + entry} / 100.0
        result
       end
       
       from = Time.parse('2012-01-01 00:00:00 UTC')
       to   = Time.now.beginning_of_month
     {  
      :cols => [['string', 'Month']] + Account.all.collect{|c| ['number', c.label]},
      :rows => (from.to_date..to.to_date).select {|_| _.day.eql?(1)}.inject([]) do |rows, day|
        row = [I18n.localize(day, :format => :table_header)] + Account.all.collect(&:id).inject([]) do |row, category_id|
           row << (entries[[day.to_time(:utc), category_id]] || 0)
           row
        end
        rows << row
        rows
      end,
      :options => {
        :height => params[:h] || '300px',
        :width => params[:w] || '100%',
        :showRowNumber => false,
        :page => 'enable',
        :pageSize => 30,
        :allowHtml => true,
        :sort => 'disable'
      },
      :formatters => Account.all.inject({}) do |formatters, account|
          formatters[formatters.count + 1] = {prefix: '', negativeColor: 'red', negativeParens: true}
          formatters
        end
      
    }
  end
  
  private
  
  def set_currency
    self.currency = self.account.currency if self.account
  end
  
  def set_amount
    if currency.eql?(Account::SYSTEM_CURRENCY)
      self.amount_in_cents = src_amount_in_cents
    else
      exchange_date = operation_date.end_of_month.future? ? Time.now : operation_date.end_of_month
      begin
        self.amount_in_cents = src_amount_in_cents.send(currency.to_sym).send("to_#{Account::SYSTEM_CURRENCY}".to_sym, :at => exchange_date).to_f.round(0)
      rescue
        logger.warn "Entry.set_amount : Exchange Rate could not be found !"
      end
    end
  end
  
end
