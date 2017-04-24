class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :last_name, :email_address, :password_digest
      t.timestamps null: false
    end
  end
end
