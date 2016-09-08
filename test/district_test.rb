require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'

class DistrictTest < Minitest::Test

  def test_sunlight_api_works
    assert_equal 15, SunlightDistrict.by_zipcode(45701).district
  end

end
