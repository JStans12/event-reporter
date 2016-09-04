require 'minitest/autorun'
require 'minitest/pride'
require './lib/queue'

class QueueTest < Minitest::Test

  def test_queue_initializes_empty
    queue = Queue.new

    assert_equal [], queue.queue
  end

end
