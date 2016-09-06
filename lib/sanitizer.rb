module Sanitizer
  extend self

  def clean_row(row)
    row[:first_name] = clean_first_name(row[:first_name])
    row[:last_name] = clean_last_name(row[:last_name])
    row[:zipcode] = clean_zipcode(row[:zipcode])
    row[:homephone] = clean_homephone(row[:homephone])
    row[:city] = clean_city(row[:city])
    row
  end

  def clean_first_name(first_name)
    first_name.strip
  end

  def clean_last_name(last_name)
    last_name.strip
  end

  def clean_homephone(homephone)
    homephone.gsub!(/[^0-9]/, "")
    return "000-000-0000"                         unless homephone.length == 10
    return homephone.insert(3,'-').insert(7,'-')  if homephone.length == 10
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def clean_city(city)
    city.to_s.strip.capitalize
  end

  def clean_state(state)
    state.to_s.strip.upcase
  end

end
