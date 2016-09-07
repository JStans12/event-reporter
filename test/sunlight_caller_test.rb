require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'

class SunlightDistrictTest < Minitest::Test

  def test_api_returns_district_info
    assert_equal 15, SunlightDistrict.district_by_zipcode(45701).district
  end

end
