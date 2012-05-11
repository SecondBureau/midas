class PaymentModesController < ApplicationController
	layout "application"
  # GET /payment_modes
  # GET /payment_modes.json
  def index
    @payment_modes = PaymentMode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_modes }
    end
  end

  # GET /payment_modes/1
  # GET /payment_modes/1.json
  def show
    @payment_mode = PaymentMode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_mode }
    end
  end

  # GET /payment_modes/new
  # GET /payment_modes/new.json
  def new
    @payment_mode = PaymentMode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment_mode }
    end
  end

  # GET /payment_modes/1/edit
  def edit
    @payment_mode = PaymentMode.find(params[:id])
  end

  # POST /payment_modes
  # POST /payment_modes.json
  def create
    @payment_mode = PaymentMode.new(params[:payment_mode])

    respond_to do |format|
      if @payment_mode.save
        format.html { redirect_to payment_modes_url, notice: 'Payment mode was successfully created.' }
        format.json { render json: @payment_mode, status: :created, location: @payment_mode }
      else
        format.html { render action: "new" }
        format.json { render json: @payment_mode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payment_modes/1
  # PUT /payment_modes/1.json
  def update
    @payment_mode = PaymentMode.find(params[:id])

    respond_to do |format|
      if @payment_mode.update_attributes(params[:payment_mode])
        format.html { redirect_to payment_modes_url, notice: 'Payment mode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment_mode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_modes/1
  # DELETE /payment_modes/1.json
  def destroy
    @payment_mode = PaymentMode.find(params[:id])
    @payment_mode.destroy

    respond_to do |format|
      format.html { redirect_to payment_modes_url }
      format.json { head :no_content }
    end
  end
end
