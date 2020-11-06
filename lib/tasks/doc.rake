
namespace :doc do

  require 'redcarpet'

  desc ".rb + .md comments -> /public/ .md, .html: path=path/to/file.rb"
  task comment: :environment do
    the_path = ENV['path'] || "./lib/monkey_patching/date.rb"
    commentariat(the_path)
  end
  
end



def commentariat(with_path)
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, no_intra_emphasis: true, autolink: true, underline: true, hightlight: true, quote: true)
html_out = ""
markdown_out = ""
html_path = './public/' + with_path.split( '/' ).last + '.html'
markdown_path = './public/' + with_path.split( '/' ).last + '.md'

html_out << %{<!DOCTYPE html>
<html lang="en-GB">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <link rel="alternate" type="text/markdown" href="#{with_path.split( '/' ).last + '.md'}">
    <style>
      body {
        max-width: 40rem;
        margin: auto;
        padding: 1rem;
        font-family: 'Helvetica Neue', system-ui;
        color: black;
        background-color: white;
      }
      p {line-height: 1.4;}
      code {
      line-height: 1.4;
      color:gray;
      }
      code pre {white-space: pre-wrap; word-break: break-word;}
      code:hover {color:black;}
      h1, h2 {font-weight:normal;}
      @media (prefers-color-scheme: dark) {
body {color:white;background-color:black;}
}
    </style>
    <title>#{with_path}</title>
  </head>
  <body>}

File.foreach(with_path).with_index do |line, line_num|

  comment_line = /^\s*#\s*(?<content>.*)/.match(line)
      
  if comment_line
  	html_out << markdown.render(comment_line["content"])  	
  	markdown_out << comment_line["content"] << "\n\n"
  elsif !(line.strip.empty?)
  	html_out << "<code title='Line #{line_num + 1}, #{with_path}'><pre><a name='#{line_num + 1}'> #{line_num + 1}</a> " << line << "</pre></code>"
  	markdown_out << line
  end
  
end

html_out << %{</body></html>}


File.write(html_path, html_out)
puts "Wrote HTML to " + html_path
File.write(markdown_path, markdown_out)
puts "Wrote Markdown to " + markdown_path
    
end
