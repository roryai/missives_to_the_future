require "./missive.rb"
require 'pry'
require 'io/console'

# if you have come to this file to nose around in my messy code then you've done so without my permission or consent. not cool.

# return to the terminal and return it to full screen with the program running

# if the program has stopped running and you're here to help out then please navigate to the directory containing this file and run `ruby operator.rb`

class Operator
  def run
    Missive.new("Test 1", "1234", "test message 1").insert
    Missive.new("Test 2", "1255", "test message 2").insert
    Missive.new("Test 3", "1266", "test message 2").insert
    read_or_write
  end

  private

  def read_or_write
    puts
    puts "#{command_prefix}Read a missive, or write a missive?" + sandwich_input_info("[r] to read, [w] to write")
    input_prefix
    command = gets.chomp
    puts
    read_or_write_handler(command)
  end

  def read_or_write_handler(command)
    case command
    when "r"
      display_missive
    when "w"
      basic_input
    else
      puts "#{command_prefix}Command not recognised. Input command again." + sandwich_input_info("[r] to read, [w] to write")
      input_prefix
      command = gets.chomp
      puts
      read_or_write_handler(command)
    end
  end

  def sandwich_input_info(input_info)
    bread = "\n  #{"*" * input_info.length}\n  "

    "\n" + bread + input_info + bread
  end

  def command_prefix
    "! "
  end

  def input_prefix
    print "> "
  end

  def display_missive
    client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'testdb')
    selected_missive_record = client[:missives].find({}).to_a.shuffle.first

    selected_missive = Missive.new(
      selected_missive_record[:name],
      selected_missive_record[:temporal_identifier],
      selected_missive_record[:message],
      selected_missive_record[:creation_time]
    )

    parts = selected_missive.prepare_for_printing
    puts `clear`

    display_hash_line

    parts.each {|part| print_text(part[0], part[1])}

    display_hash_line

    read_or_write
  end

  def display_hash_line
    terminal_columns_count = IO.console.winsize[1]
    (terminal_columns_count -1).times { print "#"}
    puts
  end

  def basic_input
    puts "#{command_prefix}What is your name?"
    puts
    input_prefix
    @name = gets.chomp
    puts
    temporal_identifier_input
    puts "#{command_prefix}Enter the missive you would like to send to the future.\n  Hit enter when you have finished.\n  WARNING: once you have hit enter you cannot edit your missive, you can only save it or discard it."
    puts
    input_prefix
    @missive_message = gets.chomp
    puts
    puts "#{command_prefix}Are you ready to submit your missive?" + sandwich_input_info("[s] to submit, [d] to delete and start again")
    input_prefix
    submission_command = gets.chomp
    submission_handler(submission_command)
  end

  def temporal_identifier_input
    puts "#{command_prefix}Enter a temporal identifier for yourself in the form of 4 digits e.g. '0806'.\n  Your missives to be linked across time, as long as you use the same name and temporal identifier."
    puts
    input_prefix
    @temporal_identifier = gets.chomp
    if !four_digits(@temporal_identifier)
      puts "! Temporal identifier must cosist of exactly 4 digits, try again."
      temporal_identifier_input
    end
    puts
  end

  def four_digits(string)
    /\b\d{4}\b/.match?(string)
  end

  def submission_handler(command)
    case command
    when 's'
      create_new_missive(@name, @temporal_identifier, @missive_message)
      puts
      puts "#{command_prefix}Missive recorded successfully.\n  Your finger movements have been stored in the temporal archive.\n  These movements can be reconstructed on demand by people in the future.\n  Thank you for your contribution to the temporal archive."
    when 'd'
      puts
      basic_input
    else
      puts "#{command_prefix}Command not recognised." + sandwich_input_info("[s] to submit, [d] to delete and start again\ Input command again:")
      input_prefix
      submission_command = gets.chomp
      submission_handler(submission_command)
    end
    puts

    read_or_write
  end

  def create_new_missive(name, temporal_identifier, missive_message)
    Missive.new(name, temporal_identifier, missive_message).insert
  end

  def print_text(text, print_rate)
    split_chars = text.split("")
    recombined_chars = []

    terminal_columns_count = IO.console.winsize[1]


    if text.length >= terminal_columns_count
      print text
    else
      split_chars.each do |char|
        recombined_chars << char
        sleep(print_rate)
        print recombined_chars.join + "\r"
      end
    end

    puts
  end
end

Operator.new.run
