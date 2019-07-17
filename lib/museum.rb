require 'pry'
class Museum
  attr_reader :name, :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
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
end
