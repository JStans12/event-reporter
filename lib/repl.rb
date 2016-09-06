require './lib/queue_manager'

class Repl
  attr_reader :queue_manager, :loaded_content

  def initialize
    @queue_manager = QueueManager.new
  end

  def main_loop
    print "what woud you like to do? \n >> "
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
      help(input[1..-1])

    when "content"
      puts queue_manager.loaded_content.count

    when "quit"
      abort

    else
      puts "#{input.join(" ")} is not a valid command"
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
      queue_manager.print_by(input[2])  if input[1]

    else
      puts "#{input.join(" ")} is not a valid command"
    end
  end


  def help(input)
  end


end
