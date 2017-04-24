class AddSetupTagToAccountsAndLines < ActiveRecord::Migration
  def change
    add_column :accounts, :setup_tag, :string
    add_column :lines, :setup_tag, :string
  end
end
