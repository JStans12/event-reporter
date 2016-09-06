require './lib/command_errors'

module CommandHelp
  include CommandErrors
  extend self

  def command_help(input)
    return command_list unless input[1]

    case input[1..-1].join(" ")

    when "load"
      puts "load full_event_attendees.csv"

    when "load <filename.csv>"
      puts "load a specified .csv file"

    when "queue count"
      puts "returns a count of all entries in the queue"

    when "queue clear"
      puts "clears the queue"

    when "queue district"
      puts "loads congressional district information to the queue"
      puts "Note: only works if the queue has less than 10 records"

    when "queue print"
      puts "prints the queue to the terminal"

    when "queue print by <attribute>"
      puts "prints the queue organized by a given attribute"

    when "queue save to <filename.csv>"
      puts "save the current queue to a specified file in csv format"

    when "queue export html <filename.html>"
      puts "create personalized spam letters for each person in the queue"

    when "find <attribute> <criteria>"
      puts "load the queue with all entries meet the specified criteria for a speified attribute"

    else
      invalid_command(input)
    end
  end

  def command_list
    puts "type help <command> to learn more"
    puts "load"
    puts "load <filename.csv>"
    puts "queue count"
    puts "queue clear"
    puts "queue district"
    puts "queue print"
    puts "queue print by <attribute>"
    puts "queue save to <filename.csv>"
    puts "queue export html <filename.html>"
    puts "find attribute <criteria>"
  end

end
