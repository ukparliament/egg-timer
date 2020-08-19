
namespace :doc do

  require 'redcarpet'

  desc "Ruby comments markdown -> HTML: path=./lib/monkey_patching/date.rb"
  task comment: :environment do
    the_path = ENV['path'] || "./lib/monkey_patching/date.rb"
    new_path = the_path + ".html"
    File.write(new_path, commentariat(the_path))
    system %{open "#{new_path}"}
  end
  
end



def commentariat(with_path)
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
out = ""
out << %{<!DOCTYPE html>
<html lang="en-GB">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
      body {
        max-width: 38rem;
        margin: auto;
        padding: 1rem;
        font-family: system-ui;
        color: black;
        background-color: white;
        font-size:larger;
      }
      p {line-height: 1.4;}
      code {
      color:lightsteelblue;
      }
      footer {
      margin:0 auto;
      color:gray;
      display:table;
      }
      footer big {
      color:crimson;
      font-weight:bold;
      font-size:2rem;}
    </style>
    <title>#{ARGV[0]}</title>
  </head>
  <body>}

File.readlines(with_path).each do |line|

  result = /^\s*#\s*(?<content>.*)/.match(line)
  
  if result
  	out << markdown.render(result["content"])
  elsif line.strip != ""
  	out << markdown.render("\t#{line}")
  end
  
end

out << %{<footer><p><big>&times;&times;&times;</big></p></footer></body></html>}
out
end
