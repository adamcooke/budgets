class AddUuids < ActiveRecord::Migration
  def change
    add_column :organizations, :uuid, :string
    add_column :periods, :uuid, :string
    add_column :accounts, :uuid, :string
    add_column :lines, :uuid, :string

    add_index :organizations, :uuid
    add_index :periods, :uuid
    add_index :accounts, :uuid
    add_index :lines, :uuid
  end
end
