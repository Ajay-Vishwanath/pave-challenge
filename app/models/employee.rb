require 'csv'

class Employee < ApplicationRecord
    belongs_to :restaurant,
        foreign_key: :restaurant_id,
        class_name: :Restaurant

    def self.import_from_csv
        table = CSV.parse(File.read('lib/assets/csv/fogoDeChao.csv'), headers: true)
        employees = table.each do |row|
            Employee.create(
                email: row["Email"].to_s || row["email"].to_s,
                first_name: row["First Name"] || row["firstName"],
                last_name: row["Last Name"] || row["lastName"],
                hire_date: row["Hire Date"] || row["startDate"],
                type: row["Type"].to_s || row["employmentType"].to_s,
                division: row["Division"] || row["department"],
                country: row["Country"] || row["country"],
                gender: row["Gender"] || row["gender"],
                base_pay: row["Base Pay"] || row["salary"],
                bonus: row["Bonus"] || row["bonus"],
                equity: row["Equity (Shares)"] || row["shares"],
                restaurant_id: 1
            )
        end
    end
end
