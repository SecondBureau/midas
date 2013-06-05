class CreateMidasRates < ActiveRecord::Migration
  def up
    create_table :refinery_midas_rates do |t|
      
      t.date :period
      
      t.integer :iit_threshold_cn, :default => 0
      t.integer :iit_threshold_foreign, :default => 0

      t.string :rates

      t.float :pension_employer_rate, :default => 0
      t.float :pension_employee_rate, :default => 0
  
      t.float :medic_employer_rate, :default => 0
      t.float :medic_employee_rate, :default => 0
      t.integer :medic_employee_fixed, :default => 0
  
      t.float :unemployment_employer_rate, :default => 0
      t.float :unemployment_employee_rate, :default => 0
  
      t.float :maternity_employer_rate, :default => 0
      t.float :maternity_employee_rate, :default => 0

      t.float :occupational_employer_rate, :default => 0
      t.float :occupational_employee_rate, :default => 0

      t.float :housing_fund_employer_rate, :default => 0
      t.float :housing_fund_employee_rate, :default => 0

      t.integer :max_insurance_benchmark, :default => 0
      t.integer :max_housing_fund_benchmark, :default => 0
      
      t.integer :account_id
      
      t.integer :salary_category_id
      t.integer :employer_social_tax_category_id
      t.integer :employee_social_tax_category_id
      t.integer :employer_housing_fund_category_id
      t.integer :employee_housing_fund_category_id
      t.integer :fesco_category_id
      t.integer :iit_category_id

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-midas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/midas/rates"})
    end

    drop_table :refinery_midas_rates

  end
end
