require "./missive.rb"
require 'pry'
require 'io/console'

class Operator

  def initialize
    @missive_storage = []
  end

  def run
    read_or_write
  end

  def read_or_write
    puts
    puts "Do you want to read a missive, or write one?\n[r] to read, [w] to write:"
    puts
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
      "Command not recognised.\n[[r] to read, [w] to write\ Input command again:"
      command = gets.chomp
      read_or_write_handler(command)
    end
  end

  def display_missive
    @missive_storage << Missive.new("Rory", "1337", "This is a test missive. Print me slowly. Or quickly. Quickly probably better to be honest, you have already made people wait in anticipation with the slow roll above.")

    selected_missive = @missive_storage.shuffle.first

    parts = selected_missive.prepare_for_printing
    parts.each {|part| print_text(part[0], part[1])}

    read_or_write
  end

  def basic_input
    puts "What is your name?"
    puts
    @name = gets.chomp
    puts
    puts "Enter a temporal identifier for yourself in the form of 4 digits e.g. '0806'.\nThis will allow your missives to be linked across time."
    puts
    @temporal_identifier = gets.chomp
    puts
    puts "Enter the missive you would like to send to the future. Hit enter when you have finished. Warning: once you have hit enter you cannot edit your missive."
    puts
    @missive_message = gets.chomp
    puts
    puts "Are you ready to submit your missive?\n[s] to submit, [d] to delete and start again."
    submission_command = gets.chomp
    submission_handler(submission_command)
  end

  def submission_handler(command)
    case command
    when 's'
      create_new_missive(@name, @temporal_identifier, @missive_message)
    when 'd'
      puts
      basic_input
    else
      puts "Command not recognised.\n[s] to submit, [d] to delete and start again\ Input command again:"
      submission_command = gets.chomp
      submission_handler(submission_command)
    end
    puts

    read_or_write
  end

  def create_new_missive(name, temporal_identifier, missive_message)
    @missive_storage << Missive.new(name, temporal_identifier, missive_message)
  end

  def input_name; end

  def input_message; end

  def omega_present?; end

  def reset_process; end

  def epsilon_present?; end

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
    puts
  end
end

Operator.new.run
