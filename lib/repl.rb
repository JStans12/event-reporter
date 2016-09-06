require './lib/queue_manager'
require './lib/command_errors'
require './lib/command_help'

class Repl
  include CommandErrors
  include CommandHelp
  attr_reader :queue_manager, :loaded_content

  def initialize
    @queue_manager = QueueManager.new
  end

  def main_loop
    print "what would you like to do? \n >> "
    handle_input(gets.chomp!.split)
  end

  ##### HANDLE RESPONSES #####

  def handle_input(input)
    case input[0]

    when "load"
      queue_manager.load             unless input[1]
      queue_manager.load(input[1])   if input[1]

    when "find"
      queue_manager.find(input[1..-1])

    when "queue"
      queue(input[1..-1])

    when "help"
      command_help(input)

    when "content"
      puts queue_manager.loaded_content.count

    when "quit"
      abort

    else
      invalid_command(input)
    end
  end


  def queue(input)
    case input[0]

    when "count"
      queue_manager.count

    when "clear"
      queue_manager.clear

    when "district"
      queue_manager.district

    when "print"
      queue_manager.print               unless input[1]
      queue_manager.print_by(input[2])  if input[1] == "by"
      invalid_command(input)            unless input[1] && input[1] == "by"

    when "save"
      queue_manager.save_to(input[2]) if input[1] == "to"
      invalid_command(input)          unless input[1] == "to"

    else
      invalid_command(input)
    end
  end

end
