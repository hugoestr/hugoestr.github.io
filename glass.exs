defmodule Glass do

  def file_name(title) do
    title
    |> String.trim()
    |> String.replace(" ", "_")
    |> String.replace(" ", "_")
    |> String.downcase()
  end

  def draft_name(title) do
    "drafts/#{file_name(title)}.html"
  end

  def draft(title) do
    name = draft_name(title)
    IO.puts "Creating #{name}"

    System.cmd("cp", ["template.html",name]) 

    git_add(name)
    git_commit("Creatingdraft for #{name}")
  end

  def publish(title) do
    name = title 
    published_name = String.replace(name, "drafts", "blog")

    System.cmd("cp", [name, "index.html"]) 
    System.cmd("mv", [name,"blog"])
   
    git_rm(name) 
    git_add(published_name) 
    git_add("index.html") 
    git_commit("Publishing  #{name}")

    git_push()
  end

  def help() do
    IO.puts("draft   -- create a draft")
    IO.puts("publish -- publish a draft")
    IO.puts("help    -- get this screen")
  end

  def git_push() do
    System.cmd("git", ["pull"]) 
    System.cmd("git", ["push"]) 
  end

  def git_add(path) do 
    System.cmd("git", ["add", path]) 
  end

  def git_rm(path) do
    System.cmd("git", ["rm", path]) 
  end

  def git_commit(message) do
    System.cmd("git", ["commit", "-m", message]) 
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
