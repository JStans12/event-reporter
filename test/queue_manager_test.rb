require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/queue_manager'

class QueueTest < Minitest::Test

  def test_queue_initializes_empty
    manager = QueueManager.new

    assert_equal [], manager.queue
  end

  def test_loaded_content_initializes_empty
    manager = QueueManager.new

    assert_equal [], manager.loaded_content
  end

  def test_load_deaults_to_full_event_attendees
    manager = QueueManager.new
    manager.load

    assert_equal 5175, manager.loaded_content.count
  end

  def test_can_load_other_files
    manager = QueueManager.new
    manager.load('event_attendees.csv')

    assert_equal 19, manager.loaded_content.count
  end

  def test_count_is_zero_before_find
    manager = QueueManager.new
    manager.load

    assert_equal 0, manager.queue.count
  end

  def test_add_to_queue_loads_the_queue
    manager = QueueManager.new
    manager.load
    manager.add_to_queue("first_name", "John")

    assert_equal 63, manager.queue.count
    assert_equal "Hoy", manager.queue[0][:last_name]
    assert manager.queue.all?{ |row| row[:first_name].downcase == "john" }
  end

  def test_clear_brings_queue_count_to_zero
    manager = QueueManager.new
    manager.load
    manager.add_to_queue("first_name", "John")

    assert_equal 63, manager.queue.count
    manager.clear
    assert_equal 0, manager.queue.count
  end

  def test_district_populates_que_last_name_gray
    manager = QueueManager.new
    manager.load
    manager.add_to_queue("last_name","Gray")
    manager.district

    assert manager.queue.all? { |row| row[:congressional_district] }
  end

  def test_district_doesnt_populate_first_name_john
    manager = QueueManager.new
    manager.load
    manager.add_to_queue("first_name","John")
    manager.district

    refute manager.queue.all? { |row| row[:congressional_district] }
  end

  def test_prints
    manager = QueueManager.new
    manager.load
    manager.add_to_queue("last_name","Gray")
    manager.district
    manager.print
  end

  def test_sort_queue_sorts_by_hash_key
    manager = QueueManager.new
    manager.queue = [ {a: 2, b: 1}, {a: 3, b: 2}, {a: 1, b: 3} ]

    assert_equal [{a: 1, b: 3}, {a: 2, b: 1}, {a: 3, b: 2}], manager.sort_queue('a')
  end

  def test_subtract_does_its_job
    manager = QueueManager.new
    manager.queue = [ {a: 2, b: 1}, {a: 3, b: 2}, {a: 1, b: 3} ]
    manager.subtract_from_queue("a", "1")

    assert_equal [ {a: 2, b: 1}, {a: 3, b: 2} ], manager.queue
  end

  def test_subtract_unless_does_its_job
    manager = QueueManager.new
    manager.queue = [ {a: 2, b: 1}, {a: 3, b: 2}, {a: 1, b: 3} ]
    manager.subtract_from_queue_unless("a", "1")

    assert_equal [ {a: 1, b: 3} ], manager.queue
  end

end
