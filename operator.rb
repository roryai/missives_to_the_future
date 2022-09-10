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

private

def input_name; end

def input_message; end

def omega_present?; end

def reset_process; end

def epsilon_present?; end

def display_missive; end

end

Operator.new.run
