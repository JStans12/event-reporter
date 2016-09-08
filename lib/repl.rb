require './lib/queue_manager'
require './lib/command_errors'
require './lib/command_help'
require 'pry'

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
      # queue_manager.find(input[1], input[2..-1])
      find(input[1..-1])

    when "add"
      queue_manager.add_to_queue(input[1], input[2..-1].join(" "))

    when "subtract"
      queue_manager.subtract_from_queue(input[1], input[2..-1].join(" "))

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
      invalid_command(input)            unless input[1] == "by" || input[1].nil?

    when "save"
      queue_manager.save_to(input[2]) if input[1] == "to"
      invalid_command(input)          unless input[1] == "to"

    when "export"
      queue_manager.export_html(input[2]) if input[1] == "html"

    when "find"
      queue_manager.subtract_from_queue_unless(input[1], input[2..-1])

    else
      invalid_command(input)
    end
  end

  def find(input)

    if input.include?("or")
      mid = input.index("or")
      find_or = true
    end

    if input.include?("and")
      mid = input.index("and")
      find_and = true
    end

    left_end = mid - 1 if mid

    queue_manager.clear

    add(input[0..left_end||=-1])

    add(input[mid+1..-1]) if find_or
    subtract_unless(input[mid+1..-1]) if find_and

  end

  def add(input)

    return queue_manager.add_to_queue(input[0], input[1..-1].join(" ")) unless input[1].include?("(")

    criteria = input[1..-1].to_a.join(" ").split(",")
    criteria.map! { |argument| argument.delete("()").strip }
    binding.pry
    criteria.each { |criteria| queue_manager.add_to_queue(input[0], criteria) }
  end

  def subtract_unless(input)

    return queue_manager.subtract_from_queue_unless(input[0], input[1..-1].join(" ")) unless input[1].include?("(")

    criteria = input[1..-1].to_a.join(" ").split(",")
    criteria.map! { |argument| argument.delete("()").strip }
    criteria.each { |criteria| queue_manager.subtract_from_queue_unless(input[0], criteria) }
  end

end
