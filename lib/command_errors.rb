module CommandErrors
  extend self

  def invalid_command(input)
    puts "#{input.join(" ")} is not a valid command"
  end

  def validate_csv_filename

  end

end
