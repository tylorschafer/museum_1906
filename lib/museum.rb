require 'pry'
class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    matches = exhibits.find_all do |exhibit|
      patron.interests.find do |interest|
        interest == exhibit.name
      end
    end
    matches
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    exhibit_interest = {}
    exhibits.each do |exhibit|
      exhibit_interest[exhibit] = []
    end
    patrons.each do |patron|
      recommend_exhibits(patron).each do |exhibit|
        exhibit_interest[exhibit] << patron
      end
    end
    exhibit_interest
  end
end
