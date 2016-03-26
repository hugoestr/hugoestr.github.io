require 'rake'

task :publish do
  ARGV.each { |a| task a.to_sym do ; end }
  draft = ARGV[1]
 
  ready_to_publish "drafts/#{draft}"
  publish draft
end

task :draft do
  ARGV.each { |a| task a.to_sym do ; end }
  name = ARGV[1]
  
  puts "creating draft #{name}"
  system "cp template.html drafts/#{name}"
end



# utilities

def add_links(doc)
  previous_links = doc.css("#previous-links").first
  links = previous_entries

  previous_links.content = links
end

def adjust(draft)
  require 'nokogiri'
  doc = Nokogiri::HTML(open draft)

  puts "adjusting file"

  change_stylesheet_location doc
  copy_meta doc 
  #add_links doc

  File.write(draft, doc.to_html) 
end

def ready_to_publish(draft)
  # add_to_rss draft
  adjust draft
  clean_cr_from draft
  move_to_blogs draft
end


def change_stylesheet_location(doc)
  puts "re-assigning stylesheet"
  
  stylesheet = doc.css('#stylesheet').first
  stylesheet.attributes["href"].value = "site.css" 
end

def clean_cr_from(draft)
  puts "cleaning carriage returns"
  
  system "tr -d '\r' < #{draft} > drafts/temp.html"
  system "mv -f temp.html drafts/#{draft}"
end

def copy_meta(doc)
  puts "copying tags to meta"

  keywords_meta = doc.css('#keywords').first
  tags = doc.css('#tags').first

  keywords_meta.attributes['content'].value = tags.content
end

def draft_commit(name)
  puts "commiting draft changes"
  `git remove drafts/#{name}`
  `git add blog/#{name}`
  `git commit -m "Cleaned up and moved #{name} from draft to blog."`
end

def index_commit(name)
  puts "git adding and commiting"
  `git add index.html`
  `git commit -m "entry #{name} published on #{Time.now.to_s}"`
end

def move_to_blogs(name)
  system "mv -f #{name} blog/#{name}"
end

def previous_entries()
end

def publish(name)
  to_index name
  draft_commit name
  index_commit name
end

def to_index(name)
  puts "copying blog/#{name} as index"
  system "cp blog/#{name} index.html"
end
