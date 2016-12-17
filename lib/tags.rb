require_relative "utils"

class Tags

  def initialize(content_dir, output_dir, template)
    @content = content_dir
    @output = output_dir
    @template = template
  end

  def create_tags()
    files = get_files @content 
    tags = create_tag_dictionary @content, files
    update_pages @content, @output, @template, tags
  end
  
  private

  def get_files(input)
    files = Dir.entries input 
    files.delete "."
    files.delete ".."
    
    result = files.select {|file| file !~ /~/ &&  file !~ /\.swp/}
    result
  end

  def create_tag_dictionary(directory, files)
    result = {}
      
    files.each do |file|
      tags = extract_tags directory, file
      next if tags.nil? || tags.empty? 

      tags.each do |tag|
        result[tag] = [] if result[tag].nil?
        result[tag] << file unless result[tag].include? file
      end
    end

    result
  end

  def extract_tags(directory, file)
    file =  "#{directory}/#{file}" 
    page = File.read file
    doc = Nokogiri::HTML page
    query = doc.css("#keywords").first
    result = [] 
    
    unless  query.nil? 
      tags = query.attributes['content'].content.split ','
      result = tags.map {|tag| tag.strip}
    end

    result
  end

  def update_pages(input_dir, directory, template, tags)
    tags.keys.each do |tag|
     file = "#{directory}/#{tag}.html"
     FileUtils.cp(@template, file) unless File.exist? file  
     doc = update_tag_page input_dir, file, tags[tag]
     name doc, tag
     to_html file, doc
    end
  end

  def update_tag_page(input_dir, file, articles)
    page = File.read file
    doc  = Nokogiri::HTML page
    links = doc.css("#related-links").first  
  
    markup = create_link_markup input_dir, articles
   
    unless markup.nil? || markup.empty?
      node = Nokogiri::HTML.fragment markup
      delete links 
      add_children links, node
    end

    doc
  end

  def create_link_markup(input_dir, articles)
   result = "" 
   markup = articles.map {|article| "<a href=\"../#{input_dir}/#{article}\" >#{article.gsub '_', ' '}</a><br />"}

   result = markup.join ' ' 
   result
  end

  def delete(links)
    links.children.each {|node| node.remove} 
  end

  def add_children(root, links)
    links.children.each {|link| root.add_child link }
  end

  def name(doc, name)
    title =  doc.css("title").first
    headline = doc.css(".title").first 

    title.content = name 
    headline.content = name
  end

end

