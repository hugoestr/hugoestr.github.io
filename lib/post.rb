require 'nokogiri'
require 'date'
require 'securerandom'
require 'fileutils'

require_relative 'git'
require_relative 'post_repo'
require_relative 'utils'

class Post

  def ready_to_publish(draft)
    path = "drafts/#{draft}"
    adjust path
    move_to_blogs draft
    add_to_rss draft
  end 

  def publish(name)
    to_index name
    change_relative_paths "index.html"

    commit = Git.new
    
    commit.draft name
    commit.index name
    commit.feed 
  end

  private

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

  def add_to_feed(markup)
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
    
    repo = PostRepo.new 'data/posts.txt'   
    repo.add data
    repo.save 

    add_to_feed markup
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

 # start here. Create the atom feed from the repo
  def create_feed()
#
#    repo = PostRepo.new 'data/posts.txt'   
#    repo.entries.sort_by{|e| e.published }.each do |entry|
#
#    end
  end

  def create_entry(data, now)
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

  def get_document_attributes(draft)
    result = {}

    now = Time.now.to_datetime.rfc3339

    page = File.read "blog/#{draft}"
    doc = Nokogiri::HTML page
    
    title = doc.css("title").first
    summary = doc.css("#summary").first
    tags = doc.css("#keywords").first

    result[:title] = title.content 
    result[:link] = "http://hugoestr.github.io/blog/#{draft}"
    result[:summary] = summary.content.strip
    result[:author] = 'Hugo Estrada' 
    result[:tags] = tags.content.split ","
    result[:published] = now
    result[:updated] = now

    result 
  end

  def move_to_blogs(name)
    system "mv -f drafts/#{name} blog"
  end

  def previous_entries()
    data = PostRepo.new 'data/posts.txt'   
    recent = data.take 3 

    markup = ""

    recent.each do |entry|
      title, link = entry.split '|'
      markup += "<a href='#{link}'>#{title}</a><br />"
    end

    Nokogiri::HTML::fragment markup
  end

  def to_index(name)
    puts "copying blog/#{name} as index"
    system "cp blog/#{name} index.html"
  end

end
