require "sqlite3"

# Open a database
db = SQLite3::Database.new "test.db"

# db.execute <<-SQL
#   DROP TABLE missives;
# SQL

# Create a table
rows = db.execute <<-SQL
  create table missives (
    name varchar,
    temporal_identifier varchar(4),
    message varchar,
    location varchar,
    gathering varchar,
    creation_time varchar
  );
SQL


db.execute("INSERT INTO missives (name, temporal_identifier, message, location, gathering, creation_time) VALUES (?, ?, ?, ?, ?, ?)",
            ["Rory test", 1234, "this is a test message", "London", "London Decom 2022", "#{Time.now}"])

# Find a few rows
db.execute( "select * from missives" ) do |row|
  p row
end
# => ["one", 1]
#    ["two", 2]

# Create another table with multiple columns
# db.execute <<-SQL
#   create table students (
#     name varchar(50),
#     email varchar(50),
#     grade varchar(5),
#     blog varchar(50)
#   );
# SQL

# Execute inserts with parameter markers
# => ["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"]
