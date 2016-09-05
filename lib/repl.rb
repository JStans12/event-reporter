require './lib/case_handler'

class Repl
  attr_reader :case_handler

  def initialize
    @case_handler = CaseHandler.new
  end

  def main_loop
    print "what woud you like to do? \n >> "
    handle_input(gets.chomp!.split)
  end

  def handle_input(input)
    case_handler.delegate(input)
  end
end
