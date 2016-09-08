module CommandErrors
  extend self

  def invalid_command(input)
    puts "#{input.join(" ")} is not a valid command"
  end

  def file_exists(input)
    File.file?(input)
  end

  def not_a_file(input)
    puts "#{input} is not a file"
  end

end
