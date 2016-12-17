require_relative "entry"

class PostRepo
  attr_reader :posts

  def initialize(file)
    @file = file
    read_file(@file) 
  end

  def add(hash_input)
    item = Entry.new
    item.parse_hash hash_input
  end

  def save()
     CSV.open(@file, "wb") do |csv|
        @posts.each do |entry|
          csv << entry.to_a 
        end
     end
  end

  private

  def read_file(file)
    File.open do |line|
      entry = Entry.new
      entry.parse_csv line

      @posts << entry
    end 
  end

end
