require './lib/repl.rb'

repl = Repl.new

puts "HELLO!"
loop do
  repl.main_loop
end
