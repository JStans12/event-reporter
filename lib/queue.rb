class Queue
  attr_accessor :queue

  def initialize
    @queue = []
  end


  def count
    puts @queue.count
    @queue.count
  end


  def clear
    puts "queue emptied"
    @queue = []
  end


  def find(input, loaded_content)
    # NEED error handling
    loaded_content.each do |row|
      queue << row if row[input[0].to_sym].downcase == input[1].downcase
    end
  end
end
