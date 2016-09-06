require 'minitest/autorun'
require 'minitest/pride'
require './lib/command_errors'
require 'csv'
require 'pry'

class CommandErrorsTest < Minitest::Test
  include CommandErrors

  def test_invalid_command_outputs_string
    invalid_command(["this", "here", "test"])
  end

  def test_if_file_exists
    assert file_exists('event_attendees.csv')
  end

end
