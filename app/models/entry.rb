class Entry < ActiveRecord::Base
  
  attr_accessible :label, :category_id, :account_id, :src_amount_in_cents,  :cheque_num, :invoice_num, :operation_date, :status
  
  belongs_to :account, :inverse_of => :entries
  belongs_to :category, :inverse_of => :entries
  
  before_validation :set_currency, :set_amount
  
  def amount
    amount_in_cents / 100.0
  end
  
  def self.datas_table_main(params=[])
    {
      :cols => [['string', 'Date'], ['string', 'Description'], ['string', 'Category'], ['string', 'Amount (CNY)'], ['string', 'Invoice'], ['string', 'Cheque'], ['string', 'Accountant']],
      :rows => Entry.where("id < ?", 100).inject([]) do |entries, entry|
        date        = entry.operation_date
        description = entry.label
        category    = entry.category.label
        amount      = entry.amount.to_s
        invoice     = entry.invoice_num
        cheque      = entry.cheque_num
        accountant  = entry.accountant_status
        entries << [date, description, category, amount, invoice, cheque, accountant]
        entries
       end, 
      :options => {
        :height => params[:h] || '300px',
        :width => params[:w] || '100%',
        :showRowNumber => true,
        :page => 'enable',
        :pageSize => 10,
        :allowHtml => true
      },
      :formatters => {
          3 => {prefix: account.currency, negativeColor: 'red', negativeParens: true}
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
        cols << ['number', 'cumul']
        cols
      end,
      :rows => (from.to_date..to.to_date).select {|_| _.day.eql?(1)}.inject([]) do |rows, day|
        row = [I18n.localize(day, :format => :table_header)] + Category.all.collect(&:id).inject([]) do |row, category_id|
           # amount of the month for the category
           row << (entries[[day.to_time(:utc), category_id]] || 0) / 100.0
           # sum of amounts for previous month for the category
           row << entries.select{|(date, cat_id), amount| date <= day.to_time(:utc) && cat_id.eql?(category_id)}.values.sum / 100.0
           row
        end
        rows << row
        rows
      end,
      :options => {
        :height => params[:h] || '300px',
        :width => params[:w] || '100%',
        :showRowNumber => true,
        :page => 'enable',
        :pageSize => 30,
        :allowHtml => true
      },
      :formatters => Category.all.inject({}) do |formatters, category|
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
        :allowHtml => true
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
