require 'minitest/autorun'
require 'minitest/pride'
require './lib/repl'

class ReplTest < Minitest::Test

  def test_repl_inits_case_handler
    repl = Repl.new

    assert repl.case_handler
    assert_equal CaseHandler, repl.case_handler.class
  end

  def test_repl_inits_case_handler_inits_queue
    repl = Repl.new

    assert repl.case_handler.queue_manager
    assert_equal Queue, repl.case_handler.queue_manager.class
  end

end
