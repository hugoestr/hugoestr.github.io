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
  end

  def publish(title) do
    name = title 

    System.cmd("cp", [name, "index.html"]) 
    System.cmd("mv", [name,"blog"])
  end
end

# The proper script starts here
[action, title | _rest] = System.argv

case action do
  "draft"   -> Glass.draft(title)
  "publish" -> Glass.publish(title)
  _         -> IO.puts("I don't know how to #{action}")
end

IO.puts("End of Script")
