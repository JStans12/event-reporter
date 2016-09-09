require './lib/repl.rb'

repl = Repl.new

puts "type help for help"
loop do
  repl.main_loop
end
