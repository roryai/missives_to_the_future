class Missive

  attr_reader :name, :message

  def initialize(name, message)
    @name = name
    @message = message
  end

  def prepare_for_printing
    [name, message]
  end
end
