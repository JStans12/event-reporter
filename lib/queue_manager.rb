require 'csv'
require 'sunlight/congress'
require './lib/district'
require './lib/sanitizer'
require './lib/sunlight_caller'
require './lib/command_errors'
require 'erb'
require 'pry'

Sunlight::Congress.api_key = "253a5251ab7b42dbadbe3291b386bad6"

class QueueManager
  include Sanitizer
  include CommandErrors
  include SunlightCaller
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
    puts ""
    puts header
    q.each do |row|
      puts format_output(row)
    end
  end

  def header
    last_name = sprintf("%-14s", "LAST_NAME")
    first_name = sprintf("%-14s", "FIRST_NAME")
    email = sprintf("%-37s", "EMAIL")
    zipcode = sprintf("%-9s", "ZIPCODE")
    city = sprintf("%-16s", "CITY")
    state = sprintf("%-7s", "STATE")
    address = sprintf("%-32s", "ADDRESS")
    phone = sprintf("%-15s", "PHONE")
    district = "DISTRICT"
    output = "#{last_name}#{first_name}#{email}#{zipcode}#{city}#{state}#{address}#{phone}#{district}"
    output
  end

  def format_output(row)
    last_name = sprintf("%-14s", row[:last_name])
    first_name = sprintf("%-14s", row[:first_name])
    email = sprintf("%-37s", row[:email_address])
    zipcode = sprintf("%-9s", row[:zipcode])
    city = sprintf("%-16s", row[:city])
    state = sprintf("%-7s", row[:state])
    address = sprintf("%-32s", row[:street])
    phone = sprintf("%-15s", row[:homephone])
    district = row[:congressional_district]
    output = "#{last_name}#{first_name}#{email}#{zipcode}#{city}#{state}#{address}#{phone}#{district}"
    output
  end

  def print_by(input)
    print(sort_queue(input))
  end

  def sort_queue(input)
    queue.sort { |a,b| a[input.to_sym] <=> b[input.to_sym]}
  end

  def load(input = 'full_event_attendees.csv')
    return not_a_file(input) unless file_exists(input)

    file_content = CSV.open input, headers: true, header_converters: :symbol
    @loaded_content = file_content.map { |row| clean_row(row) }
  end

  def find(input)
    @queue = []
    loaded_content.each do |row|
      queue << row if row[input[0].to_sym].to_s.downcase == input[1..-1].join(" ").downcase
    end
  end

  def save_to(input)
    Dir.mkdir("output-csv") unless Dir.exists?("output-csv")

    File.open("output-csv/#{input}",'w') do |file|
      queue.each do |row|
        file.puts row
      end
    end
  end

  def export_html(input)
    Dir.mkdir("output-html") unless Dir.exists?("output-html")

    File.open("output-html/#{input}",'w') do |file|
      file.puts format_table
    end
  end

  def format_table
    table_template = File.read "table_template.erb"
    erb_template = ERB.new table_template
    table = erb_template.result(binding)
  end

  # LEGISLATOR NAMES

  # def populate_queue_legislators
  #   queue.each do |person|
  #     queue_legislators << legislators_by_zipcode(person[:zipcode])
  #   end
  # end
  #
  # def legislators_by_zipcode(zipcode)
  #   Sunlight::Congress::Legislator.by_zipcode(zipcode)
  # end
  #
  # def legislators_list(index)
  #   unless queue_legislators.empty?
  #     result = ""
  #     queue_legislators[index].each do |l|
  #       result << l.first_name + " " + l.last_name + ", "
  #     end
  #     result.strip.chop
  #   end
  # end

end
