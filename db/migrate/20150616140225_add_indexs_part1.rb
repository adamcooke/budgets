class AddIndexsPart1 < ActiveRecord::Migration
  def change
    add_index :accounts, :organization_id
    add_index :periods, :organization_id
    add_index :lines, [:account_id, :period_id]
    add_index :lines, :recurring_parent_id
  end
end
