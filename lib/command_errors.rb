module CommandErrors
  extend self

  def invalid_command(input)
    puts "#{input.join(" ")} is not a valid command"
  end

  def file_exists(input)
    File.file?(input)
  end

  def validate_find_perameters

  end

end
