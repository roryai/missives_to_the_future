require 'mongo'
require 'sqlite3'

class Missive

  attr_reader :name, :temporal_identifier, :message, :location, :gathering, :creation_time

  def initialize(name, temporal_identifier, message, location, gathering, creation_time=Time.now.to_s)
    @name = name
    @temporal_identifier = temporal_identifier
    @message = message
    @location = location
    @gathering = gathering
    @creation_time = creation_time
  end

  def prepare_for_printing
    [prep_time, prep_location, prep_name, prep_gathering, ["MISSIVE CONTENTS:" + spacing("MISSIVE CONTENTS"), 0.1], prep_message]
  end

  def insert
    db = SQLite3::Database.new "missive_archive.db"
    db.execute("INSERT INTO missives (name, temporal_identifier, message, location, gathering, creation_time) VALUES (?, ?, ?, ?, ?, ?)",
                [name, temporal_identifier, message, location, gathering, creation_time])
  end

  private

  def prep_location
    pretext = "SCRIBING LOCATION:"
    [pretext + spacing(pretext) + location, 0.01]
  end

  def prep_gathering
    pretext = "GATHERING:"
    [pretext + spacing(pretext) + gathering, 0.04]
  end

  def prep_time
    pretext = "SCRIBING TIME:"
    [pretext + spacing(pretext) + creation_time.to_s, 0.01]
  end

  def prep_name
    pretext = "SCRIBE:"
    [pretext + spacing(pretext) + name, 0.08]
  end

  def prep_message
    [message, 0.02]
  end

  def spacing(pretext)
    " " * (20 - pretext.length)
  end
end
