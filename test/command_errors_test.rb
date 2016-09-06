require 'minitest/autorun'
require 'minitest/pride'
require './lib/command_errors'
require 'csv'
require 'pry'

class CommandErrorsTest < Minitest::Test

  def test_invalid_command_outputs_string
    invalid_command(["this", "here", "test"])
  end

end
