module CommandErrors
  extend self

  def invalid_command(input)
    puts "#{input.join(" ")} is not a valid command"
  end

  def validate_csv_filename(input)

  end

  def file_exists(input)
    File.file?(input)
  end

end
