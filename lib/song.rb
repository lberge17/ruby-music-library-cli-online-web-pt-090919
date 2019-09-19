require_relative './concerns/findable.rb'
require_relative './concerns/memorable.rb'

class Song
  extend Concerns::Findable, Memorable::ClassMethods
  include Memorable::InstanceMethods
  attr_accessor :name, :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist=(artist)
    end
    if genre != nil
      self.genre=(genre)
    end
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
#  def save
#    @@all << self
#  end
  
  def self.create(name, artist=nil, genre=nil)
    song = Song.new(name, artist, genre)
    song.save
    song
  end
  
  def self.new_from_filename(filename)
    name = filename.split(" - ")[1]
    artist_name = filename.split(" - ")[0]
    artist = Artist.find_or_create_by_name(artist_name)
    genre_name = filename.split(" - ")[2].chomp(".mp3")
    genre = Genre.find_or_create_by_name(genre_name)
    self.create(name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end
  
#  def self.all
#    @@all
#  end
  
  def self.destroy_all
    @@all.clear
  end
  
end