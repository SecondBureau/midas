class EntriesController < ApplicationController
  
  layout 'main'
  
  def index
    respond_to do |format|
      format.html
      format.json { render :json => Entry.send("datas_table_#{params[:table]}", params) }
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
    @entry ||= params[:id] ? Entry.find(params[:id]) : Entry.new(params[:vote])
  end
  helper_method :entry
  
  def entries
    @@entries ||= Entry.all
  end
  helper_method :entries

end
