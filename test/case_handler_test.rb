require 'minitest/autorun'
require 'minitest/pride'
require './lib/case_handler'

class CaseHandlerTest < Minitest::Test

  def test_load_deaults_to_full_event_attendees
    handler = CaseHandler.new
    handler.load

    assert_equal 5175, handler.loaded_content.count
  end

  def test_can_load_other_files
    handler = CaseHandler.new
    handler.load('event_attendees.csv')

    assert_equal 19, handler.loaded_content.count
  end

  def test_count_is_zero_before_find
    handler = CaseHandler.new
    handler.load

    assert_equal 0, handler.queue_manager.count
  end

  def test_find_loads_the_queue
    handler = CaseHandler.new
    handler.load
    handler.queue_manager.find(["first_name", "John"], handler.loaded_content)

    assert_equal 63, handler.queue_manager.count
  end

end
