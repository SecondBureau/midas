require 'open-uri'

class ApplicationController < ActionController::Base
	layout 'main'
	protect_from_forgery
	
	
	def import
		if user_signed_in?
	    :import
	  else
	    redirect_to '/'
	  end
	end

  def csv_import 
	  #if user_signed_in?
      file = params[:file]
		  @all = []
      CSV.foreach file.tempfile do |row|
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
	  #else
	  #  redirect_to '/'
    #end
  end
end
