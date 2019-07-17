require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/museum'
require './lib/patron'

class MuseumTest < Minitest:: Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_add_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    expected = [@gems_and_minerals, @dead_sea_scrolls, @imax]
    assert_equal expected, @dmns.exhibits
  end

  def test_recommend_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")
    expected = [@gems_and_minerals,@dead_sea_scrolls]
    assert_equal expected , @dmns.recommend_exhibits(@bob)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_patrons_starts_empty
    assert_equal [], @dmns.patrons
  end

  def test_admit_patron
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    expected = {
      @gems_and_minerals => [@bob]
      @dead_sea_scrolls => [@bob, @sally]
      @imax => []
    }
    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end
end
