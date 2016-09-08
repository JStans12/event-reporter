require 'pry'

class Printer
  attr_reader :format_output, :header
  attr_accessor :max_last_name, :max_first_name, :max_email_address, :max_city, :max_street

  def initialize(queue)

    @queue = queue.unshift(
      {first_name: 'FIRST_NAME',
      last_name: 'LAST_NAME',
      email_address: 'EMAIL',
      zipcode: 'ZIPCODE',
      city: 'CITY',
      state: 'STATE',
      street: 'ADDRESS',
      homephone: 'PHONE',
      congressional_district: 'DISTRICT'})

    @max_last_name = (queue.max_by { |attendee| attendee[:last_name].length })[:last_name].length + 1
    @max_first_name = (queue.max_by { |attendee| attendee[:first_name].length })[:first_name].length + 1
    @max_email_address = (queue.max_by { |attendee| attendee[:email_address].length })[:email_address].length + 1
    @max_city = (queue.max_by { |attendee| attendee[:city].length })[:city].length + 1
    @max_street = (queue.max_by { |attendee| attendee[:street].length })[:street].length + 1

    @header = @queue.shift
  end

  def format_output(attendee)
    last_name = sprintf("%-#{@max_last_name}s", attendee[:last_name])
    first_name = sprintf("%-#{@max_first_name}s", attendee[:first_name])
    email = sprintf("%-#{@max_email_address}s", attendee[:email_address])
    zipcode = sprintf("%-8s", attendee[:zipcode])
    city = sprintf("%-#{@max_city}s", attendee[:city])
    state = sprintf("%-6s", attendee[:state])
    address = sprintf("%-#{@max_street}s", attendee[:street])
    phone = sprintf("%-13s", attendee[:homephone])
    district = attendee[:congressional_district]
    output = "#{last_name}|  #{first_name}|  #{email}|  #{zipcode}|  #{city}|  #{state}|  #{address}|  #{phone}|  #{district}"
    output
  end

  def seperator
    "-" * ( @max_last_name + @max_first_name + @max_email_address + @max_city + @max_street + 60 )
  end
end
