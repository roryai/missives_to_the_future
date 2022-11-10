require 'mongo'
require 'sqlite3'

class Missive
  Mongo::Logger.logger.level = ::Logger::FATAL

  db = SQLite3::Database.new "missive_archive.db"

  attr_reader :name, :temporal_identifier, :message, :location, :gathering, :creation_time

  def initialize(name, temporal_identifier, message, creation_time=Time.now.to_s)
    @name = name
    @temporal_identifier = temporal_identifier
    @message = message
    @location = "Laniakea Supercluster, Virgo Cluster, Local Group, Milky Way, Earth, London, Fire"
    @gathering = "Decom 2022 (CE)"
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

  def read # TODO usused, delete
    client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'testdb')
    binding.pry
    client[:missives].find({})
  end

  private

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
