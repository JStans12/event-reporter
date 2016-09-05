require 'minitest/autorun'
require 'minitest/pride'
require './lib/sanitizer'
require 'csv'
require 'pry'

class SanitizerTest < Minitest::Test

  def test_zipcodes_start_all_messed_up
    file_content = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
    loaded_content = file_content.map { |row| row }

    assert_equal "7306", loaded_content[3][:zipcode]
  end

  def test_some_individual_zip_codes
    assert_equal "00000", Sanitizer.clean_zipcode("")
    assert_equal "07306", Sanitizer.clean_zipcode("7306")
    assert_equal "00123", Sanitizer.clean_zipcode("123")
  end

  def test_zipcodes_get_sanitized
    file_content = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
    loaded_content = file_content.map { |row| Sanitizer.clean_row(row) }

    assert_equal "07306", loaded_content[3][:zipcode]
  end

  def test_first_names_get_sanitized
    file_content = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
    loaded_content = file_content.map { |row| Sanitizer.clean_row(row) }

    assert_equal "David", loaded_content[3][:first_name]
  end

  def test_some_individual_first_names
    assert_equal "Joey", Sanitizer.clean_first_name("      Joey")
    assert_equal "Joey", Sanitizer.clean_first_name("Joey    ")
    assert_equal "Joey", Sanitizer.clean_first_name("      Joey    ")
  end

  def test_last_names_get_sanitized
    file_content = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
    loaded_content = file_content.map { |row| Sanitizer.clean_row(row) }

    assert_equal "Thomas", loaded_content[3][:last_name]
  end

  def test_some_individual_last_names
    assert_equal "Stansfield", Sanitizer.clean_last_name("      Stansfield")
    assert_equal "Stansfield", Sanitizer.clean_last_name("Stansfield    ")
    assert_equal "Stansfield", Sanitizer.clean_last_name("      Stansfield    ")
  end

  def test_sanitize_homephone
    assert_equal "000-000-0000", Sanitizer.clean_homephone("lakd12345(@)%(asd)")
    assert_equal "123-456-7890", Sanitizer.clean_homephone("123lkjad{@$%456}adf7890")
    assert_equal "123-456-7890", Sanitizer.clean_homephone("123-456-7890")
  end

end
