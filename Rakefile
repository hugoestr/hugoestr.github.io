require 'rake'
require 'nokogiri'

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

task :test do
end


# utilities

def add_links(doc)
  previous_links = doc.css("#previous-links").first
  links = previous_entries

  previous_links.content = links
end

def adjust(draft)
  page = File.read draft
  doc = Nokogiri::HTML page 

  puts "adjusting file"
  copy_meta doc 
  #add_links doc

  to_html draft, doc
end

def does_not_exist(name)
  result = false
  
  if File.exist? name
    puts "#{name} doesn't exist"
    result = true
  end

  result
end

def ready_to_publish(draft)
  path = "drafts/#{draft}"
  # add_to_rss draft
  adjust path
  move_to_blogs draft
end


def change_stylesheet_location(draft)
  page = File.read draft
  doc = Nokogiri::HTML page
  puts "re-assigning stylesheet"
  
  stylesheet = doc.css('#stylesheet').first
  stylesheet.attributes["href"].value = "site.css" 

  to_html draft, doc
end

def clean_cr_from(draft)
  puts "cleaning carriage returns"
  
  shell "tr -d '\\r' < #{draft} > temp.html"
  shell "mv -f temp.html #{draft}"
end

def to_windows(name)
  name.gsub "/", "\\\\"
end

def copy_meta(doc)
  puts "copying tags to meta"

  keywords_meta = doc.css('#keywords').first
  tags = doc.css('#tags').first

  keywords_meta.attributes['content'].value = tags.content
end

def draft_commit(name)
  puts "commiting draft changes"
  `git rm --cached drafts/#{name}`
  `git add blog/#{name}`
  `git commit -m "Cleaned up and moved #{name} from draft to blog."`
end

def index_commit(name)
  puts "git adding and commiting"
  `git add index.html`
  `git commit -m "entry #{name} published on #{Time.now.to_s}"`
end

def move_to_blogs(name)
  system "mv -f drafts/#{name} blog"
end

def previous_entries()
end

def publish(name)
  to_index name
  change_stylesheet_location "index.html"
  
  draft_commit name
  index_commit name
end

def shell(command)
  puts command
  system command
end

def to_html(name, doc)
  clean_cr_from name
  File.write(name, doc.to_html) 
end

def to_index(name)
  puts "copying blog/#{name} as index"
  system "cp blog/#{name} index.html"
end
