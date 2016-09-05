require 'minitest/autorun'
require 'minitest/pride'
require './lib/repl'

class ReplTest < Minitest::Test

  def test_repl_inits_queue_manager
    repl = Repl.new

    assert repl.queue_manager
    assert_equal QueueManager, repl.queue_manager.class
  end

  def test_handle_input_loads_default
    repl = Repl.new
    repl.handle_input(["load"])

    assert_equal 5175, repl.queue_manager.loaded_content.count
  end

  def test_handle_input_loads_specific
    repl = Repl.new
    repl.handle_input(["load","event_attendees.csv"])

    assert_equal 19, repl.queue_manager.loaded_content.count
  end

end
