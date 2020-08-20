
namespace :doc do

  require 'redcarpet'

<<<<<<< HEAD
  desc "Ruby comments markdown -> HTML: path=./lib/monkey_patching/date.rb"
=======
  desc ".rb with markdown comments -> .md, .html: path=path/to/file.rb"
>>>>>>> 20f8302b402642754cb8ad1c1e3a640f652aa6a7
  task comment: :environment do
    the_path = ENV['path'] || "./lib/monkey_patching/date.rb"
    new_path = './public/' + the_path.split( '/' ).last + '.html'
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
        max-width: 42rem;
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
      code:hover {color:black;}
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

File.foreach(with_path).with_index do |line, line_num|

  result = /^\s*#\s*(?<content>.*)/.match(line)
  
  if result
  	out << markdown.render(result["content"])
  elsif line.strip != ""
  	out << "<span title='Line #{line_num + 1}, #{with_path}'>" << markdown.render("\t#{line}") << "</span>"
  end
  
end

out << %{<footer><p><big>&times;&times;&times;</big></p></footer></body></html>}
out
end
