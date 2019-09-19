require_relative './concerns/findable.rb'
require_relative './concerns/memorable.rb'

class Genre
  extend Concerns::Findable, Memorable::ClassMethods
  include Memorable::InstanceMethods
  attr_accessor :name
  attr_reader :songs
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
#  def save
#    @@all << self
#  end
  
  def add_song(song)
    song.genre = self if song.genre == nil
    @songs << song if !@songs.include?(song)
  end
  
  def artists
    songs.map{|song| song.artist}.uniq
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
  
#  def self.all
#    @@all
#  end
  
  def self.destroy_all
    @@all.clear
  end
  
end