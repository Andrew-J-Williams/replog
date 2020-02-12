class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :date_created
      t.string :note
      t.integer :user_id
    end
  end
end
