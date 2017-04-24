module Budgets
  module Templates
    class Business < Abstract

      def create_structure
        # Create the period
        @period         = @budget.periods.create!(:starts_on => Date.today.beginning_of_month, :name => "First Period")
        # Create some default accounts
        @sales_acc      = @budget.accounts.create!(:name => "Sales", :account_type => "incoming")
        @or_acc         = @budget.accounts.create!(:name => "Other Revenue", :account_type => "incoming")
        @wage_acc       = @budget.accounts.create!(:name => "Salaries & Wages", :account_type => "outgoing")
        @rent_acc       = @budget.accounts.create!(:name => "Rent & Mortgages", :account_type => "outgoing")
        @marketing_acc  = @budget.accounts.create!(:name => "Marketing", :account_type => "outgoing")
        @it_acc         = @budget.accounts.create!(:name => "IT Expenses", :account_type => "outgoing")
        @cleaning_acc   = @budget.accounts.create!(:name => "Cleaning & Utilities", :account_type => "outgoing")
        @insurance_acc  = @budget.accounts.create!(:name => "Insurance", :account_type => "outgoing")
        @misc_acc       = @budget.accounts.create!(:name => "Miscellaneous", :account_type => "outgoing")
        @post_acc       = @budget.accounts.create!(:name => "Postage & Courier", :account_type => "outgoing")
        @tele_acc       = @budget.accounts.create!(:name => "Telecommunications", :account_type => "outgoing")
      end

      def create_example_data
        @sales_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Widget A Sales", :recurring => true, :amount => 3000)
        @sales_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Widget B Sales", :recurring => true, :amount => 1500)
        @sales_acc.lines.create!(:period => @period, :date => @period.starts_on + 3.months, :description => "Widget C Sales", :recurring => true, :amount => 4500)
        @sales_acc.lines.create!(:period => @period, :date => @period.starts_on + 6.months, :description => "Widget D Sales", :recurring => true, :amount => 6500)
        @sales_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Widget E Sales", :recurring => true, :amount => 7500, :months_to_recur => 2)

        @or_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Bank Account Interest", :amount => 120, :recurring => true)
        @or_acc.lines.create!(:period => @period, :date => @period.starts_on + 65.days, :description => "Sale of Bespoke Widget ABC", :amount => 10000)
        @or_acc.lines.create!(:period => @period, :date => @period.starts_on + 150.days, :description => "Sale of Bespoke Widget DEF", :amount => 9500)

        @wage_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Michael Smith Salary", :amount => 2000, :recurring => true)
        @wage_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Jane Doe Salary", :amount => 5000, :recurring => true)
        @wage_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Bob Jones Salary", :amount => 1200, :recurring => true, :months_to_recur => 4)
        @wage_acc.lines.create!(:period => @period, :date => @period.starts_on + 4.months, :description => "Peter Piper Salary", :amount => 1400, :recurring => true)

        @rent_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Warehouse Rent", :amount => 1400, :recurring => true)
        @rent_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Warehouse Service Charge", :amount => 400, :recurring => true)
        @rent_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Business Rates", :amount => 600, :recurring => true)

        @marketing_acc.lines.create!(:period => @period, :date => @period.starts_on + 4.months, :description => "Twitter AdWords", :amount => 400, :recurring => true)
        @marketing_acc.lines.create!(:period => @period, :date => @period.starts_on + 200.days, :description => "Event Sponsorship", :amount => 3000)

        @it_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Software Licencing", :amount => 50, :recurring => true)
        @it_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Budgets.io Licence", :amount => 40)

        @cleaning_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Cleaning", :amount => 120, :recurring => true)
        @cleaning_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Window Cleaning", :amount => 25, :recurring => true)

        @insurance_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Liability Insurance", :amount => 150, :recurring => true)
        @insurance_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Contents Insurance", :amount => 200, :recurring => true)

        @misc_acc.lines.create!(:period => @period, :date => @period.starts_on + 75.days, :description => "Ferret Removal Specialists", :amount => 400)

        @post_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Post", :amount => 10, :recurring => true)

        @tele_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Dial 9 VoIP Serivce", :amount => 30, :recurring => true)
        @tele_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Internet Connection", :amount => 60, :recurring => true)
        @tele_acc.lines.create!(:period => @period, :date => @period.starts_on, :description => "Line Rental", :amount => 15, :recurring => true)
      end

    end
  end
end
