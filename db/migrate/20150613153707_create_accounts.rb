class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :organization_id
      t.string :name, :account_type
      t.boolean :archived, :default => false
      t.timestamps null: false
    end
  end
end
