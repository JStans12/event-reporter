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
    case input[0]

    when "load"
      case_handler.load             unless input[1]
      case_handler.load(input[1])   if input[1]

    when "help"
      case_handler.help(input[1..-1])

    when "queue"
      case_handler.queue(input[1..-1])

    when "find"
      case_handler.find(input[1..-1])

    when "content"
      puts case_handler.loaded_content.count

    when "quit"
      abort

    else
      puts "#{input.join(" ")} is not a valid command"
    end
  end
end
