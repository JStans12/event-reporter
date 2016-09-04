require './lib/repl.rb'
require 'pry'

repl = Repl.new
loop do
  repl.main_loop
end
