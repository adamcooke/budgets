class CreateSetupValues < ActiveRecord::Migration
  def change
    create_table :setup_values do |t|
      t.integer :budget_id
      t.string :field
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.timestamps null: false
    end
  end
end
