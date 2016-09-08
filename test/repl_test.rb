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

  def test_handle_input_finds_single_criteria
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "first_name", "john"])

    assert_equal 63, repl.queue_manager.queue.count
  end

  def test_handle_input_finds_spaced_criteria
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "city", "salt", "lake", "city"])

    assert_equal 13, repl.queue_manager.queue.count
  end

  def test_handle_input_finds_multiple_criteria
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "city", "(salt", "lake", "city,", "san", "francisco)"])

    assert_equal 64, repl.queue_manager.queue.count
  end

  def test_handle_input_finds_multiple_attributes_and
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "city", "san", "francisco", "and", "first_name", "brendan"])

    assert_equal 1, repl.queue_manager.queue.count
  end

  def test_handle_input_finds_multiple_attributes_or
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "city", "san", "francisco", "or", "first_name", "brendan"])

    assert_equal 54, repl.queue_manager.queue.count
  end

  def test_handle_input_nightmare_spec
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "state", "(DC,", "VA,", "MD)", "and", "last_name", "johnson"])

    assert_equal 3, repl.queue_manager.queue.count
  end

  def test_handle_input_nightmare_queue_find
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "state", "dc", "or", "last_name", "smith"])

    assert_equal 270, repl.queue_manager.queue.count
    repl.handle_input(["queue", "find", "first_name", "alicia"])
    assert_equal 3, repl.queue_manager.queue.count
  end

  def test_add_adds_stuff
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "state", "dc", "or", "last_name", "smith"])

    assert_equal 270, repl.queue_manager.queue.count
    repl.handle_input(["add", "first_name", "jeff"])
    assert_equal 286, repl.queue_manager.queue.count
  end

  def test_subtract_subtracts_stuff
    repl = Repl.new
    repl.queue_manager.load
    repl.handle_input(["find", "state", "dc", "or", "last_name", "smith"])

    assert_equal 270, repl.queue_manager.queue.count
    repl.handle_input(["subtract", "first_name", "alicia"])
    assert_equal 267, repl.queue_manager.queue.count
  end

end
