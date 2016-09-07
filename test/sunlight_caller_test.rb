require 'minitest/autorun'
require 'minitest/pride'
require './lib/sunlight_caller'

class SunlightCallerTest < Minitest::Test
  include SunlightCaller

  def test_api_returns_district_info
    assert_equal 15, district_by_zipcode(45701).district
  end

end
