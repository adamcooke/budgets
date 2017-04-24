class RenameOrganizationToBudget < ActiveRecord::Migration
  def change
    rename_table :organizations, :budgets
    rename_column :accounts, :organization_id, :budget_id
    rename_column :periods, :organization_id, :budget_id
  end
end
