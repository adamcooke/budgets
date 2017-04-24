class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :organization_id
      t.date :starts_on, :ends_on
      t.integer :length_in_months
      t.timestamps null: false
    end
  end
end
