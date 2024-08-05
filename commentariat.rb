require 'fileutils'
require 'redcarpet'
require 'rouge'
require 'pathname'
require 'optparse'
require 'time'

class Commentariat
  def initialize(source_dir, output_dir, github_repo = nil)
    @source_dir = Pathname.new(source_dir).realpath
    @output_dir = Pathname.new(output_dir).realpath
    @github_repo = github_repo
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, with_toc_data: true)
    @formatter = Rouge::Formatters::HTML.new
    @lexer = Rouge::Lexers::Ruby.new
    @files = []
  end

  def generate_documentation
    if @source_dir == @output_dir
      puts "Error: Source directory and output directory are the same."
      puts "This could overwrite your source files. Please specify a different output directory."
      exit 1
    end

    FileUtils.mkdir_p(@output_dir)
    process_files
    generate_index
  end

  private

  def process_files
    Dir.glob(File.join(@source_dir, '**', '*.rb')).each do |file|
      relative_path = Pathname.new(file).relative_path_from(@source_dir)
      output_file = @output_dir.join(relative_path.sub_ext('.html'))
      FileUtils.mkdir_p(output_file.dirname)
      content = process_file(file)
      html_content = wrap_html(content, relative_path.to_s)
      File.write(output_file, html_content)
      @files << relative_path.to_s
    end
  end

  def process_file(file)
    content = []
    File.readlines(file).each_with_index do |line, index|
      next if line.strip.empty? # Ignore blank lines
      if line.strip.start_with?('#')
        content << process_comment(line)
      else
        content << process_code(line, index + 1, file)
      end
    end
    content.join("\n")
  end

  def process_comment(line)
    cleaned_line = line.strip.sub(/^#/, '')
    @markdown.render(cleaned_line.strip)
  end

  def process_code(line, line_number, file)
    highlighted = @formatter.format(@lexer.lex(line.chomp))
    line_link = generate_line_link(file, line_number)
    "<pre><code>#{line_link}#{highlighted}</code></pre>"
  end

  def generate_line_link(file, line_number)
    if @github_repo
      relative_path = Pathname.new(file).relative_path_from(@source_dir)
      href = "https://github.com/#{@github_repo}/blob/main/#{relative_path}#L#{line_number}"
      "<a href='#{href}' target='_blank' class='text-secondary text-decoration-none pe-2'>#{line_number}</a>"
    else
      "<span class='text-secondary pe-2'>#{line_number}</span>"
    end
  end

  def wrap_html(content, title)
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    <<~HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>#{title}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
          body { font-size: 1.1rem; }
          h1 { font-size: 1.75rem; padding-top: 1rem; }
          h2 { font-size: 1.5rem; padding-top: 0.75rem; }
          h3 { font-size: 1.25rem; padding-top: 0.5rem; }
          h4 { font-size: 1.1rem; padding-top: 0.25rem; }
          pre { margin-bottom: 0; white-space: pre-wrap; word-wrap: break-word; }
          pre code { display: block; padding: 0.5em; }
          .text-secondary pre, .text-secondary code { color: inherit !important; }
        </style>
      </head>
      <body>
        <div class="container mt-4" style="max-width: 800px;">
          <h1>#{title}</h1>
          <a href="index.html">Back to Index</a>
          <hr>
          <div class="text-secondary">
            #{content}
          </div>
          <hr>
          <p class="text-muted">Generated on: #{timestamp}</p>
        </div>
      </body>
      </html>
    HTML
  end

  def generate_index
    content = "<h1>Index</h1><ul>"
    @files.each do |file|
      html_file = file.sub(/\.rb$/, '.html')
      content << "<li><a href='#{html_file}'>#{file}</a></li>"
    end
    content << "</ul>"
    
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    index_html = <<~HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Documentation Index</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
          body { font-size: 1.1rem; }
          h1 { font-size: 1.75rem; padding-top: 1rem; }
        </style>
      </head>
      <body>
        <div class="container mt-4" style="max-width: 800px;">
          #{content}
          <hr>
          <p class="text-muted">Generated on: #{timestamp}</p>
        </div>
      </body>
      </html>
    HTML
    
    File.write(@output_dir.join('index.html'), index_html)
  end
end

# Command Line Interface
if __FILE__ == $PROGRAM_NAME
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: ruby commentariat.rb [options]"
    opts.on("-s", "--source DIR", "Source directory") do |s|
      options[:source] = s
    end
    opts.on("-o", "--output DIR", "Output directory") do |o|
      options[:output] = o
    end
    opts.on("-g", "--github REPO", "GitHub repository (e.g., 'username/repo')") do |g|
      options[:github] = g
    end
    opts.on("-h", "--help", "Prints this help") do
      puts opts
      exit
    end
  end.parse!

  if options[:source].nil? || options[:output].nil?
    puts "Error: Both source and output directories are required."
    puts "Use -h or --help for usage information."
    exit 1
  end

  begin
    documenter = Commentariat.new(options[:source], options[:output], options[:github])
    documenter.generate_documentation
    puts "Documentation generated successfully in #{options[:output]}"
  rescue Errno::ENOENT => e
    puts "Error: #{e.message}"
    exit 1
  end
end