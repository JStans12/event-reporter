require './lib/repl.rb'

repl = Repl.new

loop do
  repl.main_loop
end
