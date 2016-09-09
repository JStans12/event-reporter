module Sanitizer
  extend self

  def clean_attendee(attendee)
    attendee[:first_name] = clean_first_name(attendee[:first_name])
    attendee[:last_name] = clean_last_name(attendee[:last_name])
    attendee[:zipcode] = clean_zipcode(attendee[:zipcode])
    attendee[:homephone] = clean_homephone(attendee[:homephone])
    attendee[:city] = clean_city(attendee[:city])
    attendee[:state] = clean_state(attendee[:state])
    attendee[:street] = clean_street(attendee[:street])
    attendee
  end

  def clean_first_name(first_name)
    first_name.strip
  end

  def clean_last_name(last_name)
    last_name.strip
  end

  def clean_homephone(homephone)
    homephone.gsub!(/[^0-9]/, "")
    homephone.slice!(0)                           if homephone.length == 11
    return "000-000-0000"                         unless homephone.length == 10
    return homephone.insert(3,'-').insert(7,'-')  if homephone.length == 10
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def clean_city(city)
    city.to_s.strip.split.each { |word| word.capitalize! } .join(" ")
  end

  def clean_state(state)
    state.to_s.strip.upcase
  end

  def clean_street(street)
    street.to_s.strip
  end

end
