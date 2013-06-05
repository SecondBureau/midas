class CreateMidasSalaries < ActiveRecord::Migration
  def up
    create_table :refinery_midas_salaries do |t|
      
      t.date :period
      t.integer :monthly_in_cents, :default => 0
      t.integer :quaterly_bonus_in_cents, :default => 0
      t.integer :exceptional_bonus_in_cents, :default => 0
      t.integer :annual_bonus_in_cents, :default => 0
      t.integer :fesco_in_cents, :default => 0
      t.integer :insurance_benchmark_in_cents, :default => 0
      t.integer :housing_fund_benchmark_in_cents, :default => 0
      t.string :status
      t.integer :employee_id
      
      t.datetime :check_at
      t.datetime :salary_at
      t.datetime :social_tax_at
      t.datetime :house_fund_at
      t.datetime :fesco_at
      t.datetime :iit_at

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-midas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/midas/salaries"})
    end

    drop_table :refinery_midas_salaries

  end
end
