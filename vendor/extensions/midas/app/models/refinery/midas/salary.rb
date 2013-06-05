module Refinery
  module Midas
    class Salary < Refinery::Core::BaseModel

      belongs_to :employee, :class_name => "Refinery::Midas::Employee"

      attr_accessible :period, :monthly, :quaterly_bonus, :exceptional_bonus, :annual_bonus, :fesco, :insurance_benchmark, :housing_fund_benchmark, :status, :employee_id
      
      def title
        "#{period}"
      end
      
      def is_checked
        !self.check_at.blank?
      end

      def total_bonus
        (BigDecimal(quaterly_bonus_in_cents.to_s) + BigDecimal(exceptional_bonus_in_cents.to_s) + BigDecimal(annual_bonus_in_cents.to_s)) / 100
      end
      
      def monthly
        BigDecimal(monthly_in_cents.to_s) / 100 if monthly_in_cents?
      end
      
      def monthly=(value)
        self.monthly_in_cents = value.to_d * 100 if value.present?
      end
      
      def quaterly_bonus
        BigDecimal(quaterly_bonus_in_cents.to_s) / 100 if quaterly_bonus_in_cents?
      end
      def quaterly_bonus=(value)
        self.quaterly_bonus_in_cents = value.to_d * 100 if value.present?
      end
      
      def exceptional_bonus
        BigDecimal(exceptional_bonus_in_cents.to_s) / 100 if exceptional_bonus_in_cents?
      end
      def exceptional_bonus=(value)
        self.exceptional_bonus_in_cents = value.to_d * 100 if value.present?
      end

      def annual_bonus
        BigDecimal(annual_bonus_in_cents.to_s) / 100 if annual_bonus_in_cents?
      end
      def annual_bonus=(value)
        self.annual_bonus_in_cents = value.to_d * 100 if value.present?
      end

      def fesco
        BigDecimal(fesco_in_cents.to_s) / 100 if fesco_in_cents?
      end
      def fesco=(value)
        self.fesco_in_cents = value.to_d * 100 if value.present?
      end

      def insurance_benchmark
        BigDecimal(insurance_benchmark_in_cents.to_s) / 100 if insurance_benchmark_in_cents?
      end
      def insurance_benchmark=(value)
        self.insurance_benchmark_in_cents = value.to_d * 100 if value.present?
      end
      
      def housing_fund_benchmark
        BigDecimal(housing_fund_benchmark_in_cents.to_s) / 100 if housing_fund_benchmark_in_cents?
      end
      def housing_fund_benchmark=(value)
        self.housing_fund_benchmark_in_cents = value.to_d * 100 if value.present?
      end

    end
  end
end
