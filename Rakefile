require 'rake'

require_relative 'lib/tags'
require_relative 'lib/post'

task :help do
  puts "\n\nAhab's White Whale static site generator\n\n"

  puts ":draft          -- creates draft"
  puts ":publish        -- publishes draft"
  puts ":clear_backups  -- clean backup files "
  puts ":collect_tags   -- gathers and publishes tags"
  puts ":test           -- test currently method in development"
end

task :publish do
  ARGV.each { |a| task a.to_sym do ; end }
  draft = ARGV[1]
 
  if File.exist? "drafts/#{draft}"
    post = Post.new

    post.ready_to_publish draft
    post.publish draft
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
  tags = Tags.new "blog", "tags", "tag.html"
  tags.create_tags
end

# a task to test functions
task :test do
end


