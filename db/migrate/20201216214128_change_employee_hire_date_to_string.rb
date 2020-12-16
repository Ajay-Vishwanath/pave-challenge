class ChangeEmployeeHireDateToString < ActiveRecord::Migration[6.0]
  def change
    change_column :employees, :hire_date, :string
  end
end
