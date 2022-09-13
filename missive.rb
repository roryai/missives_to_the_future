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
    [prep_time, prep_location, prep_name, prep_gathering, ["MISSIVE CONTENTS:" + spacing("MISSIVE CONTENTS"), 0.1], prep_message]
  end

  def prep_location
    pretext = "SCRIBING LOCATION:"
    [pretext + spacing(pretext) + location, 0.02]
  end

  def prep_gathering
    pretext = "GATHERING:"
    [pretext + spacing(pretext) + gathering, 0.06]
  end

  def prep_time
    pretext = "SCRIBING TIME:"
    [pretext + spacing(pretext) + creation_time.to_s, 0.04]
  end

  def prep_name
    pretext = "SCRIBE:"
    [pretext + spacing(pretext) + name, 0.07]
  end

  def prep_message
    [message, 0.02]
  end

  def spacing(pretext)
    " " * (20 - pretext.length)
  end
end
