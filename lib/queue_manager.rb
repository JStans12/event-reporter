require 'csv'
require './lib/district'
require './lib/sanitizer'
require './lib/command_errors'
require './lib/printer'
require 'erb'

class QueueManager
  include Sanitizer
  include CommandErrors
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
    @queue = []
  end

  def district
    populate_queue_district(queue) if queue.count < 10
    puts "queue too big" if queue.count > 9
  end

  def populate_queue_district(queue)
    queue.each do |person|
      person[:congressional_district] = SunlightDistrict.by_zipcode(person[:zipcode]).district
    end
  end

  def print(q = @queue)
    return if queue.empty?
    my_printer = Printer.new(q).print
  end

  def print_by(attribute)
    print(sort_queue(attribute))
  end

  def sort_queue(attribute)
    queue.sort { |a,b| a[attribute.to_sym] <=> b[attribute.to_sym] }
  end

  def load(input_file = 'full_event_attendees.csv')
    return not_a_file(input_file) unless file_exists(input_file)

    file_content = CSV.open input_file, headers: true, header_converters: :symbol
    @loaded_content = file_content.map { |attendee| Sanitizer.clean_attendee(attendee) }
  end

  def save_to(input_file)
    Dir.mkdir("output-csv") unless Dir.exists?("output-csv")

    File.open("output-csv/#{input_file}",'w') do |file|
      file.puts " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode"
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

  def add_to_queue(attribute, criteria)
    loaded_content.each do |attendee|
      queue << attendee if attendee[attribute.to_sym].to_s.downcase == criteria.downcase
    end
    queue.uniq!
  end

  def subtract_from_queue(attribute, criteria)
    queue.delete_if do |attendee|
      attendee[attribute.to_sym].to_s.downcase == criteria.downcase
    end
  end

  def subtract_from_queue_unless(attribute, criteria)
    queue.delete_if do |attendee|
      attendee[attribute.to_sym].to_s.downcase != criteria.downcase
    end
  end

end
