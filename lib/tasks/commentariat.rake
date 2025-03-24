require 'fileutils'
require 'redcarpet'
require 'pathname'
require 'time'

class Commentariat
  def initialize(source_dir, output_dir, github_repo = nil)
    @source_dir = Pathname.new(source_dir).realpath
    @output_dir = Pathname.new(output_dir).realpath
    @github_repo = github_repo
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, with_toc_data: true)
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
    # Use HTML entities to escape special characters instead of Rouge
    code_html = CGI.escapeHTML(line.chomp)
    line_link = generate_line_link(file, line_number)
    "<pre><code>#{line_link}#{code_html}</code></pre>"
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
          pre { margin-bottom: 0; white-space: pre-wrap; word-wrap: break-word; background-color: #f8f9fa; }
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

namespace :commentariat do
  desc "Generate documentation from Ruby source files"
  task :generate, [:source, :output, :github_repo] do |t, args|
    args.with_defaults(
      source: ENV['SOURCE_DIR'] || Dir.pwd,
      output: ENV['OUTPUT_DIR'] || File.join(Dir.pwd, 'docs'),
      github_repo: ENV['GITHUB_REPO']
    )
    
    puts "Generating documentation..."
    puts "Source directory: #{args.source}"
    puts "Output directory: #{args.output}"
    puts "GitHub repository: #{args.github_repo}" if args.github_repo
    
    begin
      documenter = Commentariat.new(args.source, args.output, args.github_repo)
      documenter.generate_documentation
      puts "Documentation successfully generated in #{args.output}"
    rescue Errno::ENOENT => e
      puts "Error: #{e.message}"
      exit 1
    end
  end
  
  desc "Clean generated documentation"
  task :clean, [:output] do |t, args|
    args.with_defaults(output: ENV['OUTPUT_DIR'] || File.join(Dir.pwd, 'docs'))
    
    if File.directory?(args.output)
      puts "Removing documentation directory: #{args.output}"
      FileUtils.rm_rf(args.output)
    else
      puts "Documentation directory does not exist: #{args.output}"
    end
  end
  
  desc "Show usage information for Commentariat tasks"
  task :help do
    puts "Commentariat Documentation Generator"
    puts "===================================="
    puts
    puts "Usage:"
    puts "  rake commentariat:generate[source,output,github_repo]  # Generate documentation"
    puts "  rake commentariat:clean[output]                        # Clean documentation directory"
    puts "  rake commentariat:help                                 # Show this help"
    puts
    puts "Examples:"
    puts "  rake commentariat:generate                             # Use current dir as source, ./docs as output"
    puts "  rake commentariat:generate[lib,documentation]          # Use lib as source, documentation as output"
    puts "  rake commentariat:generate[.,docs,username/repo]       # Link to GitHub repository"
    puts "  rake commentariat:clean                                # Remove ./docs directory"
    puts
    puts "Environment variables can also be used:"
    puts "  SOURCE_DIR=lib OUTPUT_DIR=docs GITHUB_REPO=username/repo rake commentariat:generate"
  end
end
