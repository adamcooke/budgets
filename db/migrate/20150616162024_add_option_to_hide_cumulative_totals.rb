class AddOptionToHideCumulativeTotals < ActiveRecord::Migration
  def change
    add_column :budgets, :cumulative_totals, :boolean, :default => true
  end
end
