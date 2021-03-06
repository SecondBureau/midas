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
      :cols => [['date', 'Date'], ['string', 'Description'], ['string', 'Category'], ['string', 'Account'], ['number', 'Amount (CNY)'], ['string', 'Invoice'], ['string', 'Cheque'], ['string', 'Accountant']],
      :rows => Entry.order("operation_date DESC").includes(:category).includes(:account).inject([]) do |entries, entry|
        date        = entry.operation_date.strftime('%Y %B %d')#I18n.localize(entry.operation_date, :format => :short)
        description = entry.label
        category    = entry.category.label if entry.category
        account			= entry.account.label if entry.account
        amount      = entry.amount
        invoice     = entry.invoice_num
        cheque      = entry.cheque_num
        accountant  = entry.accountant_status
        entries << {"datas" => [date, description, category, account, amount, invoice, cheque, accountant], "row_style" => (entry.amount.to_i > 0) ? 'positive' : ''}
        entries
       end
     }
  end

  def self.datas_table_categories(params=[])

      entries = Entry.order("operation_date ASC").group_by{ |e| [e.operation_date.beginning_of_month, e.category_id] }.inject({}) do |result, entries|
        result[entries.first] = entries.last.collect(&:amount_in_cents).inject {|r, entry| r + entry}
        result
       end

       from = Time.parse('2011-01-01 00:00:00 UTC')
       to   = Time.now.beginning_of_month
     {
      :cols => [['date', 'Month', "rowspan"]] + Category.all.inject([]) do |cols, item|
        cols << ['number', item.label, "colspan"]
        cols
      end + [['number', 'TOTAL', "colspan"]],
      :under_cols => Category.all.inject([]) do |under_cols, item|
        under_cols << ['number', 'Month']
        under_cols << ['number', 'Balance']
        under_cols
      end + [['number', 'MONTH', 'rowspan']] + [['number', 'BALANCE', 'rowspan']],
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
        rows << {"datas" => row}
        rows
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
      :cols => [['date', 'Month']] + Account.all.collect{|c| ['number', c.label]},
      :rows => (from.to_date..to.to_date).select {|_| _.day.eql?(1)}.inject([]) do |rows, day|
        row = [I18n.localize(day, :format => :table_header)] + Account.all.collect(&:id).inject([]) do |row, category_id|
           row << (entries[[day.to_time(:utc), category_id]] || 0)
           row
        end
        rows << {"datas" => row}
        rows
      end
    }
  end

  def self.datas_table_cashflow(params=[])

    from = Date.new(2012, 5, 1)
    to   = from+1.month

    entries = Entry.order("operation_date DESC").includes(:account)
    {
      :cols => [['date', 'Date'], ['string', 'Description'], ['string', 'Account'], ['string', 'Cheque'], ['string', 'Invoice'], ['string', 'Accountant'], ['number', 'Amount (CNY)']],
      :rows => entries.inject([]) do |entries, entry|
        date        = entry.operation_date.strftime('%Y %B %d')#I18n.localize(entry.operation_date, :format => :default)
      	description = entry.label
      	account			= entry.account.label if entry.account
        cheque      = entry.cheque_num
        invoice     = entry.invoice_num
        accountant  = entry.accountant_status
        amount      = entry.amount
        entries << {"datas" => [date, description, account, cheque, invoice, accountant, amount], "row_style" => (entry.amount.to_i > 0) ? 'positive' : ''}
        entries
      end
    }
  end

  private

  def set_currency
    self.currency = self.account.currency if self.account
  end

  def set_amount
    if !account || currency.eql?(Account::SYSTEM_CURRENCY)
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
