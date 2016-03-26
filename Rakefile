require 'rake'

task :publish do
  ARGV.each { |a| task a.to_sym do ; end }

  name = ARGV[1]
  
  to_index name 
  adjust_index
  clean_carriage
  git_publish
end

task :draft do
  ARGV.each { |a| task a.to_sym do ; end }
  name = ARGV[1]
  
  puts "creating draft #{name}.html"
  system "cp template.html drafts/#{name}.html"
end

task :test do
  adjust_index
end

# utilities

def adjust_index()
  require 'nokogiri'
  file = 'index.html' 
  doc = Nokogiri::HTML(open file)

  change_stylesheet_location doc
  copy_meta doc 

  File.write(file, doc.to_html) 
end

def change_stylesheet_location(doc)
  stylesheet = doc.css('#stylesheet').first
  stylesheet.attributes["href"].value = "site.css" 
end

def clean_carriage()
  system "tr -d '\r' < index.html > temp.html"
  system "mv -f temp.html index.html"
end

def copy_meta(doc)
  keywords_meta = doc.css('#keywords').first
  tags = doc.css('#tags').first

  keywords_meta.attributes['content'].value = tags.content
end

def git_publish()
  puts "git adding and commiting"
  `git add index.html`
  `git commit -m "published on #{Time.now.to_s}"`
end

def to_index(name)
  puts "copying #{name} as index"
  system "cp #{name} index.html"
end

