class RenameEmployeeTypeToEmploymentType < ActiveRecord::Migration[6.0]
  def change
    rename_column :employees, :type, :employment_type
  end
end
