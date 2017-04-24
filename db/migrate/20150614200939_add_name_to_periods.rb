class AddNameToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :name, :string
  end
end
