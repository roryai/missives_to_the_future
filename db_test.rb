require "sqlite3"
require "pry"

# Open a database
db = SQLite3::Database.new "test.db"

db.execute <<-SQL
  DROP TABLE missives;
SQL

# Create a table
rows = db.execute <<-SQL
  create table if not exists missives (
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

db.execute("INSERT INTO missives (name, temporal_identifier, message, location, gathering, creation_time) VALUES (?, ?, ?, ?, ?, ?)",
            ["Second test", 1234, "another test message", "London", "London Decom 2022", "#{Time.now}"])


binding.pry
# Find a few rows
db.execute( "select * from missives" ) do |row|
  p row
end

puts db.execute( "select * from missives" ).shuffle.first
