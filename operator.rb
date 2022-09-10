require "./missive.rb"

class Operator

  def run
    puts "What is your name?"
    name = gets.chomp
    if name == "Ω"
      puts "Resetting"
    else
      puts name
    end
  end

  def input_name; end

  def input_message; end

  def omega_present?; end

  def reset_process; end

  def epsilon_present?; end

  def display_missive
    parts = Missive.new("Rory", "This is a test missive. Print me slowly.").prepare_for_printing
    parts.each {|part| print_text(part)}
  end

  def print_text(text)
    split_chars = text.split("")
    recombined_chars = []

    split_chars.each do |char|
      recombined_chars << char
      sleep(0.1)
      print recombined_chars.join + "\r"
    end

    puts
    puts
  end
end

Operator.new.display_missive
