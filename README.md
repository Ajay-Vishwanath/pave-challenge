# Ajay Vishwanath - Pave Challenge

## Screenshots

### Employees Endpoint
<img src="https://github.com/Ajay-Vishwanath/pave-challenge/blob/master/app/assets/images/employees.png">

### Salary Endpoint
<img src="https://github.com/Ajay-Vishwanath/pave-challenge/blob/master/app/assets/images/salary.png">

### Bonus Endpoint
<img src="https://github.com/Ajay-Vishwanath/pave-challenge/blob/master/app/assets/images/bonus.png">

## Setup
This application uses a Rails API with a Postgres database. Assuming both are installed:

* `bundle install`
* `bundle e rails db:setup`
* `rails s` which runs on localhost:3000

## Brief Overview and Key Decisions

I chose Rails to complete this challenge because it's built-in, out-out-the-box tooling made it easy to get a 3-layer web app up and running. It's also the backend technology I'm most comfortable with and know how to set up quickly.

The architecture of this web-app was pretty straightforward: I knew I wanted a `restaurants` table keeping track of the name, and then an `employees` table keeping track of all the information from the CSV files. For the purposes of our endpoints, I knew that these tables had to be relational, with `restaurants` having many `employees`, so I kept track of a `restaurant_id` in the employees table and made the ActiveRecord association accordingly. 

In my `seeds.rb` file, I created the 4 `restaurant` objects that we are ingesting data from giving them their appropriate names. I then call an `Employee` model method to ingest from the CSVs which I placed in my library folder. That `Employee` method is here: 

```Ruby
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
```

Here, I first uses Rails' CSV parser to create a CSV object out of each of the tables we are ingesting. Then, using a nested loop, I create `Employee` ActiveRecord Objects for each Employee row in those tables. The headers or column-titles are different in the CSV files, and sometimes a certain column like `bonus` doesn't exist, so I conditionally set the new `Employee` object's parameters using the || operator depending on how that CSV is structured.

For the `/employees` endpoint - all I had to do was have the controller pass all the JSON employee objects to the frontend. For the `/salary` endpoint, I used the params found in the URL to find all `Employees` who worked at that Restaurant, and then took the average of their `base_pay` using Active Record. Finally, for the `/bonus` endpoint, I used the params found in the URL to find all `Employees` with that job title and found the top 3 earners adding `base_pay`, `salary`, and `equity` with Active Record. My biggest roadblock was here: I initially stored `bonus` and `equity` values as `nil` if they didn't exist, but was running into errors with ActiveRecord or SQL trying to add those null values, and returning inaccurate information about who were actually the top earners in those roles. I worked around this by making sure that `0` was inserted in the database if the `Employee` `bonus` or `equity` didn't exist.

## What I would do with more time

1. Right now, the frontend developer has to ensure correct capitalization and spacing when trying to hit the `/salary` and `/bonus` endpoints. In the `/salary` endpoint, they have to hit `/salary/Fogo De Chao` and not `/salary/FogoDeChao` nor `/salary/fogo de chao` in order to retrieve the correct data. In the `/bonus` endpoint they have to hit `bonus/Front of house` and not `/bonus/front of house`. While a short error message exists if that frontend developer hits the wrong endpoint, it would be much more convenient if they could have some flexibility with capitalization or spacing. I could implement this by checking creating a copy of the URL params of the request, making everything lowercase and removing the spaces vs. a copy of the appropriate fieldname with everything also lowercase and without spaces. Alternatively, when I save those field values in the database, I could ensure that those values are already lowercase and without spaces. Of course, doing either of these could bring up potential errors if capitalization and spacing are important with restaurant name and employee title/division/department. 

2. Right now, the CSV ingest method is only configured for the structure of the 4 CSVs we have at hand. It looks for one or two certain spellings of a column, and then creates an `Employee` object where those columns apply. This isn't very dynamic and with how this app would exist with non-standardized CSVs from restaurants, it would be better to have a list of CSV column titles that would apply for the `Employee` parameter - i.e `base_pay` being 'Base Pay', 'base pay', 'Base Pay', 'Salary', 'salary', 'Annual Salary' and so on - and to integrate that appropriately.

3. Right now, the `hired_date` field is not standardized in the database, being stored as a string with different configurations - i.e 03/14/2020 vs. 2020/03/14. It would be best to have a function which accepted that date string and then return saved a standardized Ruby `Date` object to the database.

