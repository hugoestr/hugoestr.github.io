defmodule Git do
  def push() do
    System.cmd("git", ["pull"]) 
    System.cmd("git", ["push"]) 
  end

  def add(path) do 
    System.cmd("git", ["add", path]) 
  end

  def rm(path) do
    System.cmd("git", ["rm", path]) 
  end

  def commit(message) do
    System.cmd("git", ["commit", "-m", message]) 
  end

end

defmodule Glass do
  def file_name(title) do
    title
    |> String.trim()
    |> String.replace(" ", "_")
    |> String.replace(" ", "_")
    |> String.downcase()
  end

  def draft_name(title) do
    name = "drafts/#{file_name(title)}.html"

    IO.puts "Creating #{name}"

    System.cmd("cp", ["template.html",name]) 

    Git.add(name)
    Git.commit("Creating draft for #{name}")
  end

  def publish(title) do
    name = title 
    published_name = String.replace(name, "drafts", "blog")

    System.cmd("cp", [name, "index.html"]) 
    System.cmd("mv", [name,"blog"])
   
    Git.rm(name) 
    Git.add(published_name) 
    Git.add("index.html") 
    Git.commit("Publishing  #{name}")

    Git.push()
  end

  def help() do
    IO.puts("draft   -- create a draft")
    IO.puts("publish -- publish a draft")
  end
end

# The proper script starts here
[action, title | _rest] = System.argv

case action do
  "draft"   -> Glass.draft(title)
  "publish" -> Glass.publish(title)
  "help"    -> Glass.help()
  _         -> IO.puts("I don't know how to #{action}")
end

IO.puts("End of Script")
