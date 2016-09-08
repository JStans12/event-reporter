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
      puts "return a count of all entries in the queue"

    when "queue clear"
      puts "clear the queue"

    when "queue district"
      puts "load congressional district information to the queue"
      puts "Note: only works if the queue has less than 10 records"

    when "queue print"
      puts "print the queue to the terminal"

    when "queue print by <attribute>"
      puts "print the queue organized by a given attribute"

    when "queue save to <filename.csv>"
      puts "save the current queue to a specified file in csv format"

    when "queue export html <filename.html>"
      puts "create an html table from the queue"

    when "find <attribute> <criteria>"
      puts "clear current queue and load with all entries meet the specified criteria for a speified attribute"

    when "add <attribute> <criteria>"
      puts "add a specified attribute and criteria to the queue"

    when "subtract <attribute> <criteria>"
      puts "subtract a specified attribute and criteria from the queue"

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
    puts "find <attribute> <criteria>"
    puts "add <attribute> <criteria>"
    puts "subtract <attribute> <criteria>"
  end

end
