class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :cms_customer_id
      t.string :email
      t.string :first_name
      t.string :phone
      t.string :last_name
      t.timestamps
    end
  end
end
