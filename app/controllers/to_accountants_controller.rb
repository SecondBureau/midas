class ToAccountantsController < ApplicationController
	layout "application"
  # GET /to_accountants
  # GET /to_accountants.json
  def index
    @to_accountants = ToAccountant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @to_accountants }
    end
  end

  # GET /to_accountants/1
  # GET /to_accountants/1.json
  def show
    @to_accountant = ToAccountant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @to_accountant }
    end
  end

  # GET /to_accountants/new
  # GET /to_accountants/new.json
  def new
    @to_accountant = ToAccountant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @to_accountant }
    end
  end

  # GET /to_accountants/1/edit
  def edit
    @to_accountant = ToAccountant.find(params[:id])
  end

  # POST /to_accountants
  # POST /to_accountants.json
  def create
    @to_accountant = ToAccountant.new(params[:to_accountant])

    respond_to do |format|
      if @to_accountant.save
        format.html { redirect_to @to_accountant, notice: 'To accountant was successfully created.' }
        format.json { render json: @to_accountant, status: :created, location: @to_accountant }
      else
        format.html { render action: "new" }
        format.json { render json: @to_accountant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /to_accountants/1
  # PUT /to_accountants/1.json
  def update
    @to_accountant = ToAccountant.find(params[:id])

    respond_to do |format|
      if @to_accountant.update_attributes(params[:to_accountant])
        format.html { redirect_to @to_accountant, notice: 'To accountant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @to_accountant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /to_accountants/1
  # DELETE /to_accountants/1.json
  def destroy
    @to_accountant = ToAccountant.find(params[:id])
    @to_accountant.destroy

    respond_to do |format|
      format.html { redirect_to to_accountants_url }
      format.json { head :no_content }
    end
  end
end
