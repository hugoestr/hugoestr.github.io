require 'rake'

task :publish do
  ARGV.each { |a| task a.to_sym do ; end }

  name = ARGV[1]
  puts "copying #{name} as index"
  system "cp #{name} index.html"
  
  git_publish
end

# utilities
def git_publish()
  puts "git adding and commiting"
  `git add index.html`
  `git commit -m "published on #{Time.now.to_s}"`
end
