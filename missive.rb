class Missive

  attr_reader :location, :gathering, :creation_time, :name, :message

  def initialize(name, temporal_identifier, message)
    @name = name
    @temporal_identifier = temporal_identifier
    @message = message
    @location = "Laniakea Supercluster, Virgo Cluster, Local Group, Milky Way, Earth, Cymru"
    @gathering = "Microburn 2022 (CE)"
    @creation_time = Time.now

  end

  def prepare_for_printing
    [prep_time, prep_location, prep_name, prep_gathering, prep_message]
  end

  def prep_location
    ["Scribing location: " + location, 0.02]
  end

  def prep_gathering
    ["Gathering: " + gathering, 0.06]
  end

  def prep_time
    ["Scribing time: " + creation_time.to_s, 0.04]
  end

  def prep_name
    ["Scribe: " + name, 0.1]
  end

  def prep_message
    ["Missive contents:\n" + message, 0.02]
  end
end
