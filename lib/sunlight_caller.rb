module SunlightCaller
  extend self

  def populate_queue_district
    queue.each do |person|
      person[:congressional_district] = district_by_zipcode(person[:zipcode]).district
    end
  end

  def district_by_zipcode(zipcode)
    Sunlight::Congress::District.by_zipcode(zipcode)
  end

end
