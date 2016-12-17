def clean_cr_from(draft)
  shell "tr -d '\\r' < #{draft} > temp.html"
  shell "mv -f temp.html #{draft}"
end

def shell(command)
  puts command
  system command
end

def to_html(name, doc)
  File.write(name, doc) 
  clean_cr_from name
end
