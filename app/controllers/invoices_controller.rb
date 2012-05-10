class InvoicesController < ApplicationController
  # GET /invoices
  # GET /invoices.json
	def index

		@date_month = 0
		@date_year = 0
	
		if params[:date].nil?
			@invoices = Invoice.order("date DESC").all
		else
			date = DateTime.new()
			if (!params[:date][:year].nil? && !params[:date][:year].empty? && !params[:date][:month].nil? && !params[:date][:month].empty?)
				
				date = DateTime.new(params[:date][:year].to_i, params[:date][:month].to_i, 1)
				
				@invoices = Invoice.order("date DESC").where(:date => date..(date+1.month))
				@date_month = params[:date][:month].to_i
				@date_year = params[:date][:year].to_i
			elsif (!params[:date][:year].nil? && !params[:date][:year].empty?)
				
				date = DateTime.new(params[:date][:year].to_i, 1, 1)
				
				@invoices = Invoice.order("date DESC").where(:date => date..(date+1.year))
				@date_year = params[:date][:year].to_i
			else
				@invoices = Invoice.order("date DESC").all
			end
		end

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @invoices }
		end
	end
	
	# By month and payment mode
	def balances
		#@amount = Invoice.sum("amount").group("date")
		@amounts = Invoice.select("date, sum(amount) as total_amount, payment_mode_id, payment_modes.label AS payment_mode_label").joins(:payment_mode).group("strftime('%Y%m', date)", "payment_mode_id").order("date ASC")
		
		@tab_months = Hash.new 
		
		@amounts.each do |amount|
			if !@tab_months.include?(amount[:date].strftime("%Y-%m-01"))
				datas = Hash.new
				datas[amount[:payment_mode_id]] = amount[:total_amount]
				@tab_months[amount[:date].strftime("%Y-%m-01")] = datas
			else
				datas = @tab_months[amount[:date].strftime("%Y-%m-01")]
				datas[amount[:payment_mode_id]] = amount[:total_amount]
				@tab_months[amount[:date].strftime("%Y-%m-01")] = datas
			end
		end
		
		@payment_modes = PaymentMode.all
	end
	
	# By month and category
	def categories
		@amounts = Invoice.select("date, sum(amount) as total_amount, category_id, categories.label AS category_label").joins(:category).group("strftime('%Y%m', date)", "category_id").order("date ASC")
		
		@tab_months = Hash.new 
		
		@amounts.each do |amount|
			if !@tab_months.include?(amount[:date].strftime("%Y-%m-01"))
				datas = Hash.new
				datas[amount[:category_id]] = amount[:total_amount]
				@tab_months[amount[:date].strftime("%Y-%m-01")] = datas
			else
				datas = @tab_months[amount[:date].strftime("%Y-%m-01")]
				datas[amount[:category_id]] = amount[:total_amount]
				@tab_months[amount[:date].strftime("%Y-%m-01")] = datas
			end
		end

		@categories = Category.all
	end
	
	def cashflow
				
		@date_month = DateTime.now.month
		@date_year = DateTime.now.year
	
		if params[:date].nil?
			
			date = DateTime.new(@date_year, @date_month, 1)
			
			@invoices = Invoice.order("date DESC").where(:date => date..(date+1.month))
			@total = Invoice.select("sum(amount) as cash").where("date < ?", date).first
		else
			date = DateTime.new()
			if (!params[:date][:year].nil? && !params[:date][:year].empty? && !params[:date][:month].nil? && !params[:date][:month].empty?)
				
				date = DateTime.new(params[:date][:year].to_i, params[:date][:month].to_i, 1)
				
				@invoices = Invoice.order("date DESC").where(:date => date..(date+1.month))
				@total = Invoice.select("sum(amount) as cash").where("date < ?", date).first
				@date_month = params[:date][:month].to_i
				@date_year = params[:date][:year].to_i
			end
		end
	
		@payment_modes = PaymentMode.all
	end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @invoice = Invoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(params[:invoice])

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end
end
