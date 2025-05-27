require 'fileutils'
require 'redcarpet'
require 'pathname'
require 'time'
require 'cgi' # Add this to ensure CGI is available

class Documenter
  def initialize(output_dir = "/public/egg-timer/docs/", github_repo = "ukparliament/egg-timer")
    @source_dir = Pathname.new("./app/lib/calculations/").realpath
    # /app/controllers/calculator_controller.rb
    # /config/initializers/monkey_patching.rb
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
    collect_files
    process_files
  end

  private
  
  def collect_files
    # First collect all files as Pathname objects
    Dir.glob(File.join(@source_dir, '**', '*.rb')).each do |file|
      puts file
      relative_path = Pathname.new(file).relative_path_from(@source_dir)
      @files << relative_path
    end
    @files.sort! # Sort files alphabetically
  end

  def process_files
    @files.each do |relative_path|
      file = @source_dir.join(relative_path)
      output_file = @output_dir.join(relative_path.sub_ext('.html'))
      FileUtils.mkdir_p(output_file.dirname)
      content = process_file(file, relative_path)
      html_content = wrap_html(content, relative_path.to_s)
      File.write(output_file, html_content)
    end
  end

  def process_file(file, relative_path)
    content = []
    File.readlines(file).each_with_index do |line, index|
      next if line.strip.empty? # Ignore blank lines
      if line.strip.start_with?('#')
        content << process_comment(line)
      else
        content << process_code(line, index + 1, relative_path)
      end
    end
    content.join("\n")
  end

  def process_comment(line)
    cleaned_line = line.strip.sub(/^#/, '')
    @markdown.render(cleaned_line.strip)
  end

  def process_code(line, line_number, relative_path)
    # Use HTML entities to escape special characters
    code_html = CGI.escapeHTML(line.chomp)
    line_link = generate_line_link(relative_path, line_number)
    "<pre><code><span class='line-number'>#{line_link}</span>#{code_html}</code></pre>"
  end

  def generate_line_link(relative_path, line_number)
    if @github_repo
      # Construct GitHub URL with appropriate path
      href = "https://github.com/#{@github_repo}/blob/main/app/lib/calculations/#{relative_path}#L#{line_number}"
      "<a href='#{href}' target='_blank' class='text-secondary text-decoration-none pe-2' title='View on GitHub'>#{line_number}</a>"
    else
      "<span class='text-secondary pe-2'>#{line_number}</span>"
    end
  end

  def wrap_html(content, title)
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    
    # Generate sidebar with file list
    sidebar_content = "<h3>Files</h3>\n<ul class='list-unstyled'>\n"
    sidebar_content << "<li><a href='index.html'>Index</a></li>\n"
    @files.each do |file|
      html_file = file.to_s.sub(/\.rb$/, '.html')
      active_class = (file.to_s == title) ? "fw-bold text-primary" : ""
      sidebar_content << "<li><a href='#{html_file}' class='#{active_class}'>#{file}</a></li>\n"
    end
    sidebar_content << "</ul>"
    
    # Add custom CSS for line numbers
    custom_css = <<~CSS
      <style>
        .line-number {
          display: inline-block;
          width: 40px;
          text-align: right;
          margin-right: 10px;
        }
        pre {
          margin-bottom: 0;
          padding: 3px;
        }
        code {
          white-space: pre;
        }
      </style>
    CSS
    
    <<~HTML
      <!DOCTYPE html>
      <html lang="en-GB">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>#{title}</title>
        <link href="https://designsystem.parliament.uk/css/main.css" rel="stylesheet">
        #{custom_css}
      </head>
      <body>
      <header class="doc-header">
        <div class="container">
            <a href="https://www.parliament.uk" class="parliament-home" aria-label="UK Parliament home">
                <svg aria-hidden="true" width="159" height="40" viewBox="0 0 159 40" fill="#fff" xmlns="http://www.w3.org/2000/svg">
                    <use href="#p-icon__uk-parliament"/>
                </svg>
            </a>
        </div>
        <div class="product-header">
            <div class="container">
                <a class="title" href="/">
                        #{title}
                      </a>
            </div>
        </div>
      </header>

      <main id="main" class="main-content">
        <div class="doc-wrapper">
            <div class="container">
                <div class="row">
                  <div class="col-lg-3">
                    #{sidebar_content}
                  </div>
                    <div class="col-lg-9">
                      <h1>#{title}</h1>
                      <p>
                        <small class="text-muted">
                          View full file: 
                          <a href="https://github.com/#{@github_repo}/blob/main/app/lib/calculations/#{title}" target="_blank">
                            on GitHub
                          </a>
                        </small>
                      </p>
                      <hr>
                      <div class="text-secondary">
                        #{content}
                      </div>
                      <hr>
                      <p class="text-muted">Generated on: #{timestamp}</p>
                    </div>
                  </div>
                </div>
              </div>
          </main>
          <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-no-spacing primary">
                        &copy; UK Parliament 2025
                      </div>
                <div class="col-md-9 secondary">
                    <a href="https://www.parliament.uk/site-information/privacy/">Cookie policy</a>
                    <a data-cookie-manager-open="" href="#">Cookie settings</a>
                    <a href="https://www.parliament.uk/site-information/data-protection/data-protection-and-privacy-policy/">Privacy notice</a>
                    <a href="https://www.parliament.uk/site-information/accessibility/">Accessibility statement</a>
                    <a href="https://www.parliament.uk/site-information/copyright-parliament/">Copyright policy</a>
                </div>
            </div>
        </div>
      </footer>
      </body>
      </html>
    HTML
  end

  
end

namespace :docs do
  desc "Generate documentation from Ruby source files"
  task :new do |t, args|

    args.with_defaults(         
      output: ENV['OUTPUT_DIR'] || File.join(Dir.pwd, 'public/egg-timer/docs'),
      github_repo: ENV['GITHUB_REPO']
    )

    puts "Generating documentation..."
    puts "Source directory: /app/lib/calculations/ (fixed)"
    puts "Output directory: #{args.output}"
    puts "GitHub repository: #{args.github_repo}" if args.github_repo
    
    begin
      documenter = Documenter.new(args.output, args.github_repo)
      documenter.generate_documentation
      puts "Documentation successfully generated in #{args.output}"
    rescue Errno::ENOENT => e
      puts "Error: #{e.message}"
      exit 1
    end
  end
  
end
