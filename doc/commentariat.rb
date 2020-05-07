require 'redcarpet'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

puts %{<!DOCTYPE html>
<html lang="en-GB">
  <head>
    <meta charset="UTF-8" />
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

File.readlines(ARGV[0]).each do |line|

  result = /^\s*#\s*(?<content>.*)/.match(line)
  
  if result
  	puts markdown.render(result["content"])
  elsif line.strip != ""
  	puts markdown.render("\t#{line}")
  end
  
end

puts %{<footer><p><big>&times;&times;&times;</big></p></footer></body></html>}
