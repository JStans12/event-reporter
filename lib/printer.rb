module Printer
  extend self

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

  def format_output(attendee)
    last_name = sprintf("%-14s", attendee[:last_name])
    first_name = sprintf("%-14s", attendee[:first_name])
    email = sprintf("%-37s", attendee[:email_address])
    zipcode = sprintf("%-9s", attendee[:zipcode])
    city = sprintf("%-16s", attendee[:city])
    state = sprintf("%-7s", attendee[:state])
    address = sprintf("%-32s", attendee[:street])
    phone = sprintf("%-15s", attendee[:homephone])
    district = attendee[:congressional_district]
    output = "#{last_name}#{first_name}#{email}#{zipcode}#{city}#{state}#{address}#{phone}#{district}"
    output
  end

end
