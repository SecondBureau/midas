class EntriesController < ApplicationController
  
  layout 'main'
  
  DEFAULT_TABLE='main'
  
  def index
		if user_signed_in?
    	table ||= ( params[:table] || DEFAULT_TABLE)
    	@entries = Entry.send("datas_table_#{table}", params)
		else
			redirect_to '/admin'
		end
  end

  def show
  end

  def edit
  end

  def new
  end

  def update
  end

  def destroy
  end
  
  private 
  
  def entry
    @entry ||= params[:id] ? Entry.find(params[:id]) : Entry.new(params[:entry])
  end
  helper_method :entry
  
  def entries
  	if user_signed_in?
    	@entries ||= Entry.all
    else
    	redirect_to '/admin'
    end
  end
  helper_method :entries
  
  def table
    @table ||= ( params[:table] || DEFAULT_TABLE)
  end
  helper_method :table

end
