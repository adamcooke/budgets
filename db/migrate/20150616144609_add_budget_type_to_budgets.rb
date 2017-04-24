class AddBudgetTypeToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :budget_type, :string
    add_column :budgets, :example, :boolean, :default => false
  end
end
