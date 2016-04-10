require 'rake'
require 'nokogiri'
require 'date'
require 'securerandom'
require 'fileutils'

require_relative 'lib/tags'

task :publish do
  ARGV.each { |a| task a.to_sym do ; end }
  draft = ARGV[1]
 
  if File.exist? "drafts/#{draft}"
    ready_to_publish draft
    publish draft
  else
    puts "Can't publish.\ndrafts/#{draft} doesn't exist"
  end
end

task :draft do
  ARGV.each { |a| task a.to_sym do ; end }
  name = ARGV[1]
  
  puts "creating draft #{name}"
  system "cp template.html drafts/#{name}"
end

task :clear_backups do
  shell "rm blog/*.*~"  
  shell "rm tags/*.*~"  
end

task :collect_tags do
  create_tags
end

# a task to test functions
task :test do
end

# utilities

def create_tags()
  tags = Tags.new "blog", "tags", "tag.html"
  tags.create_tags
end

def add_links(doc)
  previous_links = doc.css("#previous-links").first
  entries = previous_entries
  entries.children.each {|child| previous_links.add_child child }
end

def add_publish_date(doc)
  date = doc.css("#published-date").first
  today = Time.new
  date.content = today.strftime "%m-%d-%Y"
end

def add_to_dom(markup)
  node = Nokogiri::XML::fragment markup
  file = "feed.atom"
  feed = File.read file 

  doc = Nokogiri::XML feed
  updated = doc.css("updated").first
  updated.content = Time.now.to_datetime.rfc3339
  updated.after node
 
  FileUtils.cp "feed.atom", "backup.atom"
  to_html file, doc.to_html
end

def add_to_rss(draft)
  data = get_document_attributes draft
  markup = create_entry data
  add_to_dom markup 
end



def adjust(draft)
  page = File.read draft
  doc = Nokogiri::HTML page 

  puts "adjusting file"
  copy_meta doc 
  copy_title doc 
  add_links doc
  add_publish_date doc

  to_html draft, doc.to_html
end

def change_relative_paths(draft)
  page = File.read draft
  reformatted = page.gsub 'href="../', 'href="'

  to_html draft, reformatted
end

def clean_cr_from(draft)
  puts "cleaning carriage returns"
  
  shell "tr -d '\\r' < #{draft} > temp.html"
  shell "mv -f temp.html #{draft}"
end

def copy_meta(doc)
  puts "copying meta to tags"

  keywords = doc.css('#keywords').first
  tags = doc.css('#tags').first

  links = create_tag_links "tags",  keywords.attributes['content'].content
  links.children.each {|link| tags.add_child link}
end

def copy_title(doc)
  puts "copying headline to title"

  title = doc.css('title').first
  headline = doc.css('.title').first

  title.content = headline.content
end

def create_entry(data)
 now = Time.now.to_datetime.rfc3339
  result = <<END
  \n\n  <entry>
    <title>#{data[:title]}</title>
    <link href="#{data[:link]}" />
    <updated>#{now}</updated> 
    <published>#{now}</published>
    <summary>#{data[:summary]}</summary>
    <author><name>Hugo Estrada</name></author>
END

  data[:tags].each {|tag| result += "    <category term='#{tag}' />\n" }
  result +=  "    <id>urn:uuid:#{SecureRandom.uuid.to_s}</id>\n"
  result += "  </entry>"

  result
end

def create_tag_links(tag_directory, tag_string)
  puts tag_string
  tags = tag_string.split(",").map do |item|
    tag = item.strip  
    "<a href=\"../#{tag_directory}/#{tag}.html\">#{tag}</a> " 
  end
 
  result = Nokogiri::HTML::fragment (tags.join '')
end

def does_not_exist(name)
  result = false
  
  if File.exist? name
    puts "#{name} doesn't exist"
    result = true
  end

  result
end

def draft_commit(name)
  puts "commiting draft changes"
  `git add blog/#{name}`
  `git rm draft/#{name}`
  `git commit -m "Cleaned up and moved #{name} from draft to blog."`
end

def feed_commit()
  `git add feed.atom backup.atom`
  `git commit -m "Updating feeds."`
end

def index_commit(name)
  puts "git adding and commiting"
  `git add index.html`
  `git commit -m "entry #{name} published on #{Time.now.to_s}"`
end

def get_document_attributes(draft)
  result = {}

  page = File.read "blog/#{draft}"
  doc = Nokogiri::HTML page
  
  title = doc.css("title").first
  summary = doc.css("#summary").first
  tags = doc.css("#tags").first

  result[:title] = title.content 
  result[:link] = "http://hugoestr.github.io/blog/#{draft}"
  result[:summary] = summary.content.strip
  result[:tags] = tags.content.split ","

  result 
end

def move_to_blogs(name)
  system "mv -f drafts/#{name} blog"
end

def previous_entries()
  feed = File.read "feed.atom"
  xml = Nokogiri::XML feed
  entries = xml.css("entry")

  recent = entries.take 3

  markup = ""

  recent.each do |entry|
    title = entry.css("title").first
    link = entry.css("link").first
    markup += "<a href='#{link.attributes["href"]}'>#{title.content}</a><br />"
  end

  Nokogiri::HTML::fragment markup
end

def publish(name)
  to_index name
  change_relative_paths "index.html"
  
  draft_commit name
  index_commit name
  feed_commit 
end

def ready_to_publish(draft)
  path = "drafts/#{draft}"
  adjust path
  move_to_blogs draft
  add_to_rss draft
end

def shell(command)
  puts command
  system command
end

def to_html(name, data)
  File.write(name, data) 
  clean_cr_from name
end

def to_index(name)
  puts "copying blog/#{name} as index"
  system "cp blog/#{name} index.html"
end
