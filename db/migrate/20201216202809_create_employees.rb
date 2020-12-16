class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.date :hire_date
      t.string :type
      t.string :division
      t.string :country
      t.string :gender
      t.integer :base_pay
      t.integer :bonus
      t.integer :equity

      t.timestamps
    end
  end
end
