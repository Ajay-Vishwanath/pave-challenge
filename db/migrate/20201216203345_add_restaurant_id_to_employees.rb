class AddRestaurantIdToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :restaurant_id, :integer
  end
end
