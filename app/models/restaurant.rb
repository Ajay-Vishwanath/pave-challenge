class Restaurant < ApplicationRecord
    has_many :employees,
        primary_key: :id,
        foreign_key: :restaurant_id,
        class_name: :Employee

end
