module Refinery
  module Midas
    class Rate < Refinery::Core::BaseModel
    
      serialize :rates, Array

      attr_accessible :period, :rates, :iit_threshold_cn,:iit_threshold_foreign,:pension_employer_rate,:pension_employee_rate,:medic_employer_rate
      attr_accessible :medic_employee_rate,:medic_employee_fixed,:unemployment_employer_rate,:unemployment_employee_rate, :maternity_employer_rate,:maternity_Employee_rate
      attr_accessible :occupational_employer_rate,:occupational_employee_rate,:housing_fund_employer_rate,:housing_fund_employee_rate,:max_insurance_benchmark, :max_housing_fund_benchmark
      attr_accessible :account_id, :salary_category_id, :employer_social_tax_category_id, :employee_social_tax_category_id, :iit_category_id
      attr_accessible :employer_housing_fund_category_id, :employee_housing_fund_category_id, :fesco_category_id

      before_save :rates_string_to_array
      
      belongs_to :account, :foreign_key => 'midas_account_id'

      belongs_to :salary_category, :class_name => "Refinery::Midas::Category", :foreign_key => :salary_category_id
      belongs_to :employer_social_tax_category, :class_name => "Refinery::Midas::Category", :foreign_key => :employer_social_tax_category_id
      belongs_to :employee_social_tax_category, :class_name => "Refinery::Midas::Category", :foreign_key => :employee_social_tax_category_id
      belongs_to :employer_housing_fund_category, :class_name => "Refinery::Midas::Category", :foreign_key => :employer_housing_fund_category_id
      belongs_to :employee_housing_fund_category, :class_name => "Refinery::Midas::Category", :foreign_key => :employee_housing_fund_category_id
      belongs_to :fesco_category, :class_name => "Refinery::Midas::Category", :foreign_key => :fesco_category_id
      belongs_to :iit_category, :class_name => "Refinery::Midas::Category", :foreign_key => :iit_category_id

      def title
        period
      end
      
      def insurance_employer_rate
        pension_employer_rate + medic_employer_rate + unemployment_employer_rate + maternity_employer_rate + occupational_employer_rate
      end
      
      def insurance_employee_rate
        pension_employee_rate + medic_employee_rate + unemployment_employee_rate + maternity_employee_rate + occupational_employee_rate
      end
      
      def rates_string_to_array
        self.rates = eval(rates)
      end
    end
  end
end
