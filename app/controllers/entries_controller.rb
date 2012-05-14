class EntriesController < ApplicationController
  
  layout 'main'
  
  DEFAULT_TABLE='main'
  
  def index  
    respond_to do |format|
      format.html
      format.json { render :json => Entry.send("datas_table_#{params[:table]}", params) }
      format.js
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
    @entries ||= Entry.all
  end
  helper_method :entries
  
  def table
    @table ||= ( params[:table] || DEFAULT_TABLE)
  end
  helper_method :table

end
