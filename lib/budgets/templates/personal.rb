module Budgets
  module Templates
    class Personal < Abstract

      def create_structure
        # Create the period
        @period         = @budget.periods.create!(:starts_on => Date.today.beginning_of_month, :name => "First Period")

        # Create some default accounts
        @salary_acc     = @budget.accounts.create!(:name => "Salary/Wages", :account_type => "incoming", :setup_tag => 'salary')
        @tips_acc       = @budget.accounts.create!(:name => "Tips & Bonuses", :account_type => "incoming", :setup_tag => 'tips-bonuses')
        @interest_acc   = @budget.accounts.create!(:name => "Interest Received", :account_type => "incoming", :setup_tag => 'interest')

        @utilities_acc          = @budget.accounts.create!(:name => "Utilities", :account_type => "outgoing", :setup_tag => 'utilities')
        @rent_acc               = @budget.accounts.create!(:name => "Rent/Mortgage", :account_type => "outgoing", :setup_tag => 'rent-mortgage')
        @taxes_acc              = @budget.accounts.create!(:name => "Taxes", :account_type => "outgoing", :setup_tag => 'taxes')
        @vehicle_acc            = @budget.accounts.create!(:name => "Vehicle Expenses", :account_type => "outgoing", :setup_tag => 'vehicle')
        @shopping_acc           = @budget.accounts.create!(:name => "Shopping", :account_type => "outgoing", :setup_tag => 'shopping')
        @insurance_acc          = @budget.accounts.create!(:name => "Insurance", :account_type => "outgoing", :setup_tag => 'insurance')
        @misc_acc               = @budget.accounts.create!(:name => "Miscellaneous", :account_type => "outgoing", :setup_tag => 'misc')
        @entertainment_acc      = @budget.accounts.create!(:name => "Entertainment", :account_type => "outgoing", :setup_tag => 'entertainment')
        @gifts_acc              = @budget.accounts.create!(:name => "Gifts", :account_type => "outgoing", :setup_tag => 'gifts')
        @clothing_acc           = @budget.accounts.create!(:name => "Clothing", :account_type => "outgoing", :setup_tag => 'clothing')
      end

      def create_example_data
        @salary_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Salary from Main Job", :recurring => true, :amount => 1530)
        @tips_acc.lines.create!(:period => @period, :date => @period.starts_on + 3.months, :description => "Bonus", :amount => 1000)

        @utilities_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Water", :amount => 10, :recurring => true)
        @utilities_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Electricity", :amount => 20, :recurring => true)
        @utilities_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Gas", :amount => 20, :recurring => true)
        @utilities_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "TV Licence", :amount => 145/12.0, :recurring => true)
        @utilities_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Mobile Phone", :amount => 35.00, :recurring => true)

        @rent_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Rent", :amount => 790, :recurring => true)

        @taxes_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Council Tax", :amount => 1050 / 12.0, :recurring => true)

        @vehicle_acc.lines.create!(:period => @period, :date => @period.starts_on + 3.months, :description => "Fuel", :amount => 50, :recurring => true)
        @vehicle_acc.lines.create!(:period => @period, :date => @period.starts_on + 6.months, :description => "Servicing", :amount => 250)
        @vehicle_acc.lines.create!(:period => @period, :date => @period.starts_on + 7.months, :description => "Vehicle Excise Duty", :amount => 80)
        @vehicle_acc.lines.create!(:period => @period, :date => @period.starts_on + 8.months, :description => "MOT", :amount => 40)

        @shopping_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Groceries", :amount => 100, :recurring => true)

        @insurance_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Contents Insurance", :amount => 10, :recurring => true)
        @insurance_acc.lines.create!(:period => @period, :date => @period.starts_on + 3.months, :description => "Car Insurance", :amount => 19, :recurring => true)

        @misc_acc.lines.create!(:period => @period, :date => @period.starts_on + 100.days, :description => "Amazon DVD", :amount => 14.99)

        @clothing_acc.lines.create!(:period => @period, :date => @period.starts_on + 140.days, :description => "Jeans", :amount => 29.99)
        @clothing_acc.lines.create!(:period => @period, :date => @period.starts_on + 204.days, :description => "Jacket", :amount => 79.99)

        @entertainment_acc.lines.create!(:period => @period, :date => @period.starts_on + 2.months, :description => "Netflix", :amount => 9.99)
        @entertainment_acc.lines.create!(:period => @period, :date => @period.starts_on + 200.days, :description => "New TV", :amount => 400.00)
        @entertainment_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Gym Subscription", :amount => 39.50, :recurring => true)

        @gifts_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Children Pocket Money", :amount => 10, :recurring => true)
        @gifts_acc.lines.create!(:period => @period, :date => @period.starts_on + 75.days, :description => "Donation to Cancer Care", :amount => 50)
        @gifts_acc.lines.create!(:period => @period, :date => @period.starts_on + 208.days, :description => "Donation to Cancer Care", :amount => 50)
      end


      field :salary, :account => 'salary', :type => 'money'
      field :tips, :account => 'tips-bonuses', :type => 'money'
      field :interest, :account => 'interest', :type => 'money'

      field :electricity, :account => 'utilities', :type => 'money'
      field :gas, :account => 'utilities', :type => 'money'
      field :water, :account => 'utilities', :type => 'money'
      field :mobile, :account => 'utilities', :type => 'money'
      field :internet, :account => 'utilities', :type => 'money'
      field :rent_mortgage, :account => 'rent-mortgage', :type => 'money'
      field :tax, :account => 'taxes', :type => 'money'

      field :home_insurance, :account => 'insurance', :type => 'money'
      field :life_insurance, :account => 'insurance', :type => 'money'
      field :health_insurance, :account => 'insurance', :type => 'money'

      field :vehicle_fuel, :account => 'vehicle', :type => 'money'
      field :vehicle_insurance, :account => 'vehicle', :type => 'money'
      field :vehicle_servicing, :account => 'vehicle', :type => 'money'

    end
  end
end
