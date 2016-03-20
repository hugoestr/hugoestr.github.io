require 'rake'

task :publish do
  ARGV.each { |a| task a.to_sym do ; end }

  name = ARGV[1]
  puts "copying #{name} as index"
  exec "cp #{name} index.html"
end
