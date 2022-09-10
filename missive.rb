class Missive

  attr_reader :location, :gathering, :creation_time, :name, :message

  def initialize(name, message)
    @location = "Laniakea Supercluster, Virgo Cluster, Local Group, Milky Way, Earth, Cymru"
    @gathering = "Microburn 2022 (CE)"
    @creation_time = Time.now
    @name = name
    @message = message
  end

  def prepare_for_printing
    [prep_time, prep_location, prep_name, prep_gathering, prep_message]
  end

  def prep_location
    "Scribing location: " + location
  end

  def prep_gathering
    "Gathering: " + gathering
  end

  def prep_time
    "Scribing time: " + creation_time.to_s
  end

  def prep_name
    "Scribe: " + name
  end

  def prep_message
    "Missive contents: " + message
  end
end
