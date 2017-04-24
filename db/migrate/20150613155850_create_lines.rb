class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :period_id, :account_id
      t.date :date
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :description

      t.boolean :recurring, :default => false
      t.integer :months_to_recur
      t.integer :recurring_parent_id

      t.timestamps null: false
    end
  end
end
