require 'csv'
require 'sunlight/congress'
require './lib/district'
require './lib/sanitizer'
require 'pry'

Sunlight::Congress.api_key = "253a5251ab7b42dbadbe3291b386bad6"

class QueueManager
  attr_accessor :queue, :loaded_content, :queue_legislators

  def initialize
    @queue = []
    @loaded_content = []
    @queue_legislators = []
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

  def populate_queue_district
    queue.each do |person|
      person[:congressional_district] = district_by_zipcode(person[:zipcode]).district
      #queue_district << district_by_zipcode(person[:zipcode])
    end
  end

  def district_by_zipcode(zipcode)
    Sunlight::Congress::District.by_zipcode(zipcode)
  end

  def print
    puts ""
    puts header
    queue.each_with_index do |row, index|
      puts format_output(row, index)
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

  def format_output(row, index)
    last_name = sprintf("%-14s", row[:last_name])
    first_name = sprintf("%-14s", row[:first_name])
    email = sprintf("%-37s", row[:email_address])
    zipcode = sprintf("%-9s", row[:zipcode])
    city = sprintf("%-16s", row[:city])
    state = sprintf("%-7s", row[:state])
    address = sprintf("%-32s", row[:street])
    phone = sprintf("%-15s", row[:homephone])
    district = row[:congressional_district]
    # district = queue_district[index].district unless queue_district.empty?
    output = "#{last_name}#{first_name}#{email}#{zipcode}#{city}#{state}#{address}#{phone}#{district}"
    output
  end

  def print_by(input)
    sort_queue(input)
    print
  end

  def sort_queue(input)
    repopulate = true unless @queue_district.empty?
    @queue_district = []
    queue.sort! { |a,b| a[input.to_sym] <=> b[input.to_sym]}
    district if repopulate
  end

  def load(input = 'full_event_attendees.csv')
    file_content = CSV.open input, headers: true, header_converters: :symbol
    @loaded_content = file_content.map { |row| Sanitizer.clean_row(row) }
  end

  def find(input)
    @queue = []
    @queue_legislators = []
    @queue_district = []
    loaded_content.each do |row|
      queue << row if row[input[0].to_sym].to_s.downcase == input[1..-1].join(" ").downcase
    end
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
