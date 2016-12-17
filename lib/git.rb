class Git 
  def draft(name)
    puts "commiting draft changes"
    `git add blog/#{name}`
    `git rm draft/#{name}`
    `git commit -m "Cleaned up and moved #{name} from draft to blog."`
  end

  def feed()
    `git add feed.atom backup.atom`
    `git commit -m "Updating feeds."`
  end

  def index(name)
    puts "git adding and commiting"
    `git add index.html`
    `git commit -m "entry #{name} published on #{Time.now.to_s}"`
  end
end
