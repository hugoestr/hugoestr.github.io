require 'csv'

class Entry
  attr_accessor :title, :link, :summary, :author, :published
  attr_accessor :updated, :tags

  def initialize()
  end

  def parse_hash(data)
    @published = data[:published]
    @updated = data[:updated]
    @title = data[:title]
    @link = data[:link]
    @summary = data[:summary]
    @author = data[:author]
    @tags = data[tags]
  end

  def parse_csv(line)
    data = CSV.parse line
    
    @published = data[0]
    @updated = data[1]
    @title = data[2]
    @link = data[3]
    @summary = data[4]
    @author = data[5]
    @tags = data[6].split ";"
  end

  def to_a()
    [@published, @updated, "#{@title}", 
     @link, "#{@summary}", "#{@author}", 
     "#{@tags.join ';'}"]
  end

end

