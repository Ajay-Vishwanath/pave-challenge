require 'csv'

class Employee < ApplicationRecord
    belongs_to :restaurant,
        foreign_key: :restaurant_id,
        class_name: :Restaurant

    def self.import_from_csv
        tableOne = CSV.parse(File.read('lib/assets/csv/fogoDeChao.csv'), headers: true)
        tableTwo = CSV.parse(File.read('lib/assets/csv/gamine.csv'), headers: true)
        tableThree = CSV.parse(File.read('lib/assets/csv/hookfish.csv'), headers: true)
        tableFour = CSV.parse(File.read('lib/assets/csv/zenYai.csv'), headers: true)

        tables = [tableOne, tableTwo, tableThree, tableFour]

        tables.each_with_index do |table, idx|
            employees = table.each do |row|
                Employee.create(
                    email: row["Email"]|| row["email"],
                    first_name: row["First Name"] || row["firstName"],
                    last_name: row["Last Name"] || row["lastName"],
                    hire_date: row["Hire Date"] || row["startDate"],
                    employment_type: row["Type"] || row["employmentType"],
                    division: row["Division"] || row["department"],
                    country: row["Country"] || row["country"],
                    gender: row["Gender"] || row["gender"],
                    base_pay: row["Base Pay"] || row["salary"] || 0,
                    bonus: row["Bonus"] || row["bonus"] || 0,
                    equity: row["Equity (Shares)"] || row["shares"] || 0,
                    restaurant_id: idx + 1
                )
            end
        end
    end
end
