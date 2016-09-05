require './lib/queue'
require './lib/sanitizer'
require 'csv'

class CaseHandler
  attr_reader :loaded_content, :queue_manager

  def initialize
    @queue_manager = Queue.new
  end


  def delegate(input)
    case input[0]

    when "load"
      load             unless input[1]
      load(input[1])   if input[1]

    when "help"
      help(input[1..-1])

    when "queue"
      queue(input[1..-1])

    when "find"
      queue_manager.find(input[1..-1], @loaded_content)

    when "content"
      puts loaded_content.count

    when "quit"
      abort

    else
      puts "#{input.join(" ")} is not a valid command"
    end
  end


  def load(input = 'full_event_attendees.csv')
    # NEED error handling
    file_content = CSV.open input, headers: true, header_converters: :symbol
    @loaded_content = file_content.map { |row| Sanitizer.clean_row(row) }
  end


  def queue(input)
    case input[0]

    when "count"
      queue_manager.count

    when "clear"
      queue_manager.clear

    else
      puts "#{input.join(" ")} is not a valid command"
    end
  end


  def help(input)
  end


end
