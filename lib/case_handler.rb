require './lib/queue'
require 'csv'

class CaseHandler
  attr_reader :loaded_content, :queue_manager

  def initialize
    @queue_manager = Queue.new
  end

  def delegate

  end


  def load(input = 'full_event_attendees.csv')
    # NEED error handling
    file_content = CSV.open input, headers: true, header_converters: :symbol
    @loaded_content = file_content.map do |row|
      row
    end
  end


  def find(input)
    queue_manager.find(input, @loaded_content)
  end


  def queue(input)
    # NEED error handling
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
