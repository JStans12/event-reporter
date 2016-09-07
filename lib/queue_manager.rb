require 'csv'
require 'sunlight/congress'
require './lib/district'
require './lib/sanitizer'
require './lib/sunlight_caller'
require './lib/command_errors'
require './lib/printer'
require 'erb'

Sunlight::Congress.api_key = "253a5251ab7b42dbadbe3291b386bad6"

class QueueManager
  include Sanitizer
  include CommandErrors
  include SunlightCaller
  include Printer
  attr_accessor :queue, :loaded_content

  def initialize
    @queue = []
    @loaded_content = []
  end

  def count
    puts @queue.count
    @queue.count
  end

  def clear
    puts "queue emptied"
    @queue = []
  end

  def district
    populate_queue_district if queue.count < 10
    puts "queue too big" if queue.count > 9
  end

  def print(q = @queue)
    return if queue.empty?
    puts ""
    puts header
    q.each do |attendee|
      puts format_output(attendee)
    end
  end

  def print_by(attribute)
    print(sort_queue(attribute))
  end

  def sort_queue(attribute)
    queue.sort { |a,b| a[attribute.to_sym] <=> b[attribute.to_sym]}
  end

  def load(input_file = 'full_event_attendees.csv')
    return not_a_file(input_file) unless file_exists(input_file)

    file_content = CSV.open input_file, headers: true, header_converters: :symbol
    @loaded_content = file_content.map { |attendee| clean_attendee(attendee) }
  end

  def find(attribute, criteria)
    @queue = []
    loaded_content.each do |attendee|
      queue << attendee if attendee[attribute.to_sym].to_s.downcase == criteria.join(" ").downcase
    end
  end

  def save_to(input_file)
    Dir.mkdir("output-csv") unless Dir.exists?("output-csv")

    File.open("output-csv/#{input_file}",'w') do |file|
      file.puts
      queue.each do |row|
        file.puts row
      end
    end
  end

  def export_html(input_file)
    Dir.mkdir("output-html") unless Dir.exists?("output-html")

    File.open("output-html/#{input_file}",'w') do |file|
      file.puts format_table
    end
  end

  def format_table
    table_template = File.read "table_template.erb"
    erb_template = ERB.new table_template
    table = erb_template.result(binding)
  end

end
