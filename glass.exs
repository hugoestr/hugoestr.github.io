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
end

[title | _rest] = System.argv
name = Glass.draft_name(title)

IO.puts "Creating #{name}"
System.cmd("cp", ["template.html",name]) 
