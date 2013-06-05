module Refinery
  module Midas
    module Admin
      class SalariesController < ::Refinery::AdminController
      
        helper_method :iit_amount

        after_filter :add_flash_message, :only => :destroy
        
        before_filter :new, :only => :index
        
        crudify :'refinery/midas/salary', :xhr_paging => true, :order => "period DESC", :sortable => false
        
        def add_flash_message
          flash[:error] = @entry.errors.messages.values.join('<br/>') if @entry.errors.messages.any?
        end
        
        def month_report
          @date = Date.parse(params[:date])
          @salaries = Salary.where(:period => @date..@date.end_of_month)
          @rate = get_rate(@date)
        end
        
        def get_rate(date)
          Rate.where(:period => date..date.end_of_month).order("period DESC").first
          if !@rate
            @rate = Rate.where("period < ?", date).order("period DESC").first
          end
        end

        def update_event
          date = Date.new(params[:year].to_i, params[:month].to_i, 1)
          @salaries = Salary.where(:period => date..date.end_of_month)
          
          @salaries.update_all(params[:event] => params[:date])

          rate = get_rate(date)
          
          net_salaries_code = rate.salary_category.code
          employer_social_tax_code = rate.employer_social_tax_category.code
          employee_social_tax_code = rate.employee_social_tax_category.code
          employer_housing_fund_code = rate.employer_housing_fund_category.code
          employer_housing_fund_code = rate.employee_housing_fund_category.code
          fesco_code = rate.fesco_category.code
          iit_code = rate.iit_category.code

          account = rate.account
          
          message = "The payroll has been checked"
          
          if params[:event] == "salary_at"
            @salaries.each do |salary|
              Entry.create(
                :category => Category.where(:code => "#{net_salaries_code}.#{salary.employee.category.code.split('.')[1]}").first,
                :account => account,
                :src_amount => -1 * (salary.monthly + salary.total_bonus),
                :valid_after => params[:date],
                :title => salary.employee.name)
            end
            message = "Entries for salaries have been created"
          elsif params[:event] == "social_tax_at"
            @salaries.each do |salary|
              insurance_benchmark = [salary.insurance_benchmark, rate[:max_insurance_benchmark]].min
              Entry.create(
                :category => Category.where(:code => "#{employee_social_tax_code}.#{salary.employee.category.code.split('.')[1]}").first,
                :account => account,
                :src_amount => rate.medic_employee_fixed + ((insurance_benchmark * rate.insurance_employee_rate / 100).round(2)),
                :valid_after => params[:date],
                :title => "Employee Social Tax : #{salary.employee.name}")
                
              Entry.create(
                :category => Category.where(:code => "#{employer_social_tax_code}.#{salary.employee.category.code.split('.')[1]}").first,
                :account => account,
                :src_amount => (insurance_benchmark * rate.insurance_employer_rate / 100).round(2),
                :valid_after => params[:date],
                :title => "Employer Social Tax : #{salary.employee.name}")
            end
            message = "Social Tax entries have been created"
          elsif params[:event] == "house_fund_at"
            @salaries.each do |salary|
              housing_fund_benchmark = [salary.housing_fund_benchmark, rate[:max_housing_fund_benchmark]].min
              Entry.create(
                :category => Category.where(:code => "#{employee_housing_fund_code}.#{salary.employee.category.code.split('.')[1]}").first,
                :account => account,
                :src_amount => (housing_fund_benchmark * rate[:housing_fund_employee_rate] / 100).round(2),
                :valid_after => params[:date],
                :title => "Employee House fund : #{salary.employee.name}")
              Entry.create(
                :category => Category.where(:code => "#{employer_housing_fund_code}.#{salary.employee.category.code.split('.')[1]}").first,
                :account => account,
                :src_amount => (housing_fund_benchmark * rate[:housing_fund_employer_rate] / 100).round(2),
                :valid_after => params[:date],
                :title => "Employer House fund : #{salary.employee.name}")
            end
            message = "House fund entries have been created"
          elsif params[:event] == "fesco_at"
            @salaries.each do |salary|
              Entry.create(
                :category => Category.where(:code => "#{fesco_code}.#{salary.employee.category.code.split('.')[1]}").first,
                :account => account,
                :src_amount => salary.fesco,
                :valid_after => params[:date],
                :title => "Fesco : #{salary.employee.name}")
            end
            message = "Fesco entries have been created"
          elsif params[:event] == "iit_at"
            @salaries.each do |salary|
              Entry.create(
                :category => Category.where(:code => "#{iit_code}.#{salary.employee.category.code.split('.')[1]}").first,
                :account => account,
                :src_amount => iit_amount(salary, rate, false) + iit_amount(salary, rate, true),
                :valid_after => params[:date],
                :title => "IIT : #{salary.employee.name}")
            end
            message = "IIT entries have been created"
          end
          
          redirect_to refinery.midas_admin_salaries_path, :notice => message
        end
        
        def iit_amount(salary, rate, is_bonus)
          insurance_benchmark = [salary.insurance_benchmark, rate[:max_insurance_benchmark]].min
          total_employee = rate.medic_employee_fixed + (insurance_benchmark * rate.insurance_employee_rate / 100)

          if !salary.employee.foreigner
            housing_fund_benchmark = [salary.housing_fund_benchmark, rate[:max_housing_fund_benchmark]].min
            total_employee = total_employee + (housing_fund_benchmark * rate[:housing_fund_employee_rate] / 100)
          end
          
          income = salary.monthly - total_employee
          taxable_income = 0
          
          if !is_bonus
            if salary.employee.foreigner
              taxable_income = income - rate[:iit_threshold_foreign]
            else
              taxable_income = income - rate[:iit_threshold_cn]
            end
          else
            taxable_income = salary.total_bonus / 12;
          end
          
          if taxable_income < 0
            taxable_income = 0
          end

          min_amount = 0
          previous_max_amount = 0
          iit_rate = 0
          quick_deduction = 0
      
          rate[:rates].each do |amount, r, qd|
            min_amount = previous_max_amount
            previous_max_amount = amount
            if (taxable_income > min_amount && taxable_income <= amount)
              iit_rate = r
              quick_deduction = qd
            end
          end

          if !is_bonus
            ((taxable_income * iit_rate) - quick_deduction).round(2)
          else
            ((salary.total_bonus * iit_rate) - quick_deduction).round(2)
          end
        end
      end
    end
  end
end
