require 'nokogiri'

page = File.read "feed.atom"
doc = Nokogiri::XML page
entries = doc.css("entry")

entries.each do |entry|
  title = entry.css("title").first
  link = entry.css("link").first
  summary = entry.css("summary").first
  author = entry.css("name").first
  published = entry.css("published").first
  updated = entry.css("updated").first

  tags_entries = entry.css("category")

  tags = ""

  tags_entries.each do |tag|
    tags << tag["term"] << ";"
  end
  

  puts "#{published.text},#{updated.text},\"#{title.content}\",#{link["href"]},\"#{summary.content}\",#{author.content},\"#{tags}\"" 
end

